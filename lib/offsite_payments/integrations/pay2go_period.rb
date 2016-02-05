# encoding: utf-8
require 'digest'
require File.dirname(__FILE__) + '/pay2go_period/helper.rb'
require File.dirname(__FILE__) + '/pay2go_period/notification.rb'

module OffsitePayments #:nodoc:
  module Integrations #:nodoc:
    module Pay2goPeriod

      VERSION = '1.0'
      RESPOND_TYPE = 'String'
      CHECK_VALUE_FIELDS = %w(PeriodAmt MerchantID MerchantOrderNo TimeStamp PeriodType)
      CHECK_CODE_FIELDS = %w(PeriodType MerchantID MerchantOrderNo)

      mattr_accessor :service_url
      mattr_accessor :merchant_id
      mattr_accessor :hash_key
      mattr_accessor :hash_iv
      mattr_accessor :debug

      def self.service_url
        mode = ActiveMerchant::Billing::Base.mode
        case mode
          when :production
            'https://api.pay2go.com/API/PeriodAPI'
          when :development
            'https://capi.pay2go.com/API/PeriodAPI'
          when :test
            'https://capi.pay2go.com/API/PeriodAPI'
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
        end
      end

      def self.notification(post)
        Notification.new(post)
      end

      def self.setup
        yield(self)
      end
    end
  end
end
