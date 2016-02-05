# encoding: utf-8
require 'digest'

module OffsitePayments #:nodoc:
  module Integrations #:nodoc:
    module Pay2goPeriod
      class Notification < OffsitePayments::Notification
        PARAMS_FIELDS = %w(
          Status Message MerchantID MerchantOrderNo PeriodType authDate authTime dateArray PeriodTotalAmt
          PeriodFirstAmt PeriodAmt CheckCode
        )

        PARAMS_FIELDS.each do |field|
          define_method field.underscore do
            @params[field]
          end
        end

        def success?
          status == 'SUCCESS'
        end

        # TODO 使用查詢功能實作 acknowledge
        # Pay2go 沒有遠端驗證功能，
        # 而以 checksum_ok? 代替
        def acknowledge
          checksum_ok?
        end

        def complete?
          %w(SUCCESS CUSTOM).include? status
        end

        def checksum_ok?
          raw_data = URI.encode_www_form OffsitePayments::Integrations::Pay2goPeriod::CHECK_CODE_FIELDS.sort.map { |field|
            [field, @params[field]]
          }

          hash_raw_data = "HashIV=#{OffsitePayments::Integrations::Pay2goPeriod.hash_iv}&#{raw_data}&HashKey=#{OffsitePayments::Integrations::Pay2goPeriod.hash_key}"
          Digest::SHA256.hexdigest(hash_raw_data).upcase == check_code
        end
      end
    end
  end
end
