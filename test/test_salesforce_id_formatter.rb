require 'minitest_helper'

class TestSalesforceIdFormatter < Minitest::Test
  def test_to_18
    assert_equal valid_18_chars, SalesforceIdFormatter.to_18(valid_18_chars)
    assert_equal valid_18_chars, SalesforceIdFormatter.to_18(valid_15_chars)
    assert_equal valid_18_chars, SalesforceIdFormatter.to_18(with_encoded_space_15)
    assert_equal valid_18_chars, SalesforceIdFormatter.to_18(with_encoded_space_18)

    assert_raises SalesforceIdFormatter::InvalidId do
      SalesforceIdFormatter.to_18(too_short)
    end

    assert_raises SalesforceIdFormatter::InvalidId do
      SalesforceIdFormatter.to_18(too_long)
    end

    assert_raises SalesforceIdFormatter::InvalidId do
      SalesforceIdFormatter.to_18(invalid_chars)
    end
  end

  def test_to_15
    assert_equal valid_15_chars, SalesforceIdFormatter.to_15(valid_15_chars)
    assert_equal valid_15_chars, SalesforceIdFormatter.to_15(valid_18_chars)

    assert_raises SalesforceIdFormatter::InvalidId do
      SalesforceIdFormatter.to_15(too_short)
    end

    assert_raises SalesforceIdFormatter::InvalidId do
      SalesforceIdFormatter.to_15(too_long)
    end

    assert_raises SalesforceIdFormatter::InvalidId do
      SalesforceIdFormatter.to_15(invalid_chars)
    end
  end

  def test_valid_id?
    assert_equal true, SalesforceIdFormatter.valid_id?(valid_15_chars)
    assert_equal true, SalesforceIdFormatter.valid_id?(valid_18_chars)
    assert_equal false, SalesforceIdFormatter.valid_id?(too_short)
    assert_equal false, SalesforceIdFormatter.valid_id?(too_long)
    assert_equal false, SalesforceIdFormatter.valid_id?(invalid_chars)
  end

  private

  def valid_15_chars
    '70130000001tcyI'
  end

  def valid_18_chars
    '70130000001tcyIAAQ'
  end

  def too_short
    'TooShort'
  end

  def too_long
    'ThisSalesforceIDisWayTooLong'
  end

  def invalid_chars
    '15InvalidChars!'
  end

  def with_encoded_space_15
    '%2070130000001tcyI'
  end

  def with_encoded_space_18
    '%2070130000001tcyIAAQ'
  end
end
