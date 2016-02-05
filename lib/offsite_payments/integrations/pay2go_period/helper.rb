# encoding: utf-8
require 'digest'

module OffsitePayments #:nodoc:
  module Integrations #:nodoc:
    module Pay2goPeriod
      class Helper < OffsitePayments::Helper
        FIELDS = %w(
          MerchantID MerchantOrderNo PeriodAmt ProdDesc PeriodAmtMode PeriodType PeriodPoint PeriodStartType
          PeriodTimes ReturnURL ProDetail PeriodMemo PaymentInfo OrderInfo InvoiceInfo NotifyURL
        )

        FIELDS.each do |field|
          mapping field.underscore.to_sym, field
        end
        mapping :account, 'MerchantID' # AM common

        def initialize(order, account, options = {})
          super
          add_field 'MerchantID', OffsitePayments::Integrations::Pay2goPeriod.merchant_id
          add_field 'Version', OffsitePayments::Integrations::Pay2goPeriod::VERSION
          add_field 'RespondType', OffsitePayments::Integrations::Pay2goPeriod::RESPOND_TYPE
        end

        def time_stamp(date)
          add_field 'TimeStamp', date.to_time.to_i
        end

        def encrypted_data
          raw_data = URI.encode_www_form OffsitePayments::Integrations::Pay2goPeriod::CHECK_VALUE_FIELDS.sort.map { |field|
            [field, @fields[field]]
          }

          hash_raw_data = "HashKey=#{OffsitePayments::Integrations::Pay2goPeriod.hash_key}&#{raw_data}&HashIV=#{OffsitePayments::Integrations::Pay2goPeriod.hash_iv}"
          add_field 'CheckValue', Digest::SHA256.hexdigest(hash_raw_data).upcase
        end

      end
    end
  end
end
