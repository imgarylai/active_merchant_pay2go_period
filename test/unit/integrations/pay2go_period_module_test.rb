require 'test_helper'

class Pay2goPeriodModuleTest < Minitest::Test
  include OffsitePayments::Integrations

  def test_notification_method
    assert_instance_of Pay2goPeriod::Notification, Pay2goPeriod.notification('name=cody')
  end
end
