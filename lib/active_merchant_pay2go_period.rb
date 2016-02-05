require 'action_view'
require 'active_merchant_pay2go_period/version'
require 'active_merchant'
require 'offsite_payments'
require 'active_support/core_ext/string'
require 'uri'

module OffsitePayments
  module Integrations
    autoload :Pay2goPeriod, 'offsite_payments/integrations/pay2go_period'
  end
end

ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
