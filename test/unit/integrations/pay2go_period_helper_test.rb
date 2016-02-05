require 'test_helper'

class Pay2goPeriodHelperTest < Minitest::Test
  include OffsitePayments::Integrations

  def setup
  end

  def test_check_value
    @helper = Pay2goPeriod::Helper.new 'sdfasdfa', '123456'
    @helper.add_field 'PeriodType', 'M'
    @helper.add_field 'MerchantID', '123456'
    @helper.add_field 'MerchantOrderNo','20140901001'
    @helper.add_field 'TimeStamp', '1403243286'
    @helper.add_field 'PeriodAmt', '200'

    OffsitePayments::Integrations::Pay2goPeriod.hash_key = 'GADlNOKdHiTBjdgW6uAjngF9ItT6nCW4'
    OffsitePayments::Integrations::Pay2goPeriod.hash_iv = 'dzq1naf5t8HMmXIs'

    @helper.encrypted_data
    # HashKey=GADlNOKdHiTBjdgW6uAjngF9ItT6nCW4&Amt=200&MerchantID=123456&MerchantOrderNo=20140901001&TimeStamp=1403243286&Version=1.2&HashIV=dzq1naf5t8HMmXIs
    assert_equal 'F2DCD13F563195A22AC3C845FC401ECBF07890130E98BAF87F0652791DF555DE', @helper.fields['CheckValue']
  end

end
