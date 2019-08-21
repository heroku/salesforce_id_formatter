require 'minitest_helper'

class TestSalesforceIdFormatter < Minitest::Test
  def test_to_18
    assert_equal valid_18_chars, SalesforceIdFormatter.to_18(valid_18_chars)

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

  # Simple exercise of the to15 method
  def test_to_15_basic
    validate_to_15_map(to_15_basic_map)
  end

  # Test for more complex mixes of case
  def test_to_15_advanced
    validate_to_15_map(to_15_advanced_map)
  end

  # test that various mixed case 3-char suffixes are handled correctly
  def test_to_15_mixed_suffix_case
    validate_to_15_map(to_15_mixed_suffix_case_map)
  end

  def test_to_18_basic
    to_18_basic_map.each do |input_test_id, expected_test_id|
      assert_equal expected_test_id, SalesforceIdFormatter.to_18(input_test_id)
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

  def validate_to_15_map(test_ids_map)
    test_ids_map.each do |input_test_id, expected_test_id|
      assert_equal expected_test_id, SalesforceIdFormatter.to_15(input_test_id)
    end
  end

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

  def to_15_basic_map
    {
      valid_18_chars => valid_15_chars,
      'ABCDEFGHIJKLMNOAAA' => 'abcdefghijklmno',
      'abcdefghijklmno555' => 'ABCDEFGHIJKLMNO',
      'AbCdEfGhIjKlMnOAAA' => 'abcdefghijklmno',
      'AbCdEfGhIjKlMnO555' => 'ABCDEFGHIJKLMNO'
    }
  end

  def to_15_advanced_map
    {
      'AbCdEfGhIjKlMnOA5A' => 'abcdeFGHIJklmno',
      'AbCdEfGhIjKlMnO5A5' => 'ABCDEfghijKLMNO',
      'abcdefghijklmnoVKV' => 'AbCdEfGhIjKlMnO',
      'abcdefghijklmnoKVK' => 'aBcDeFgHiJkLmNo'
    }
  end

  def to_15_mixed_suffix_case_map
    {
      'AbCdEfGhIjKlMnOa5a' => 'abcdeFGHIJklmno',
      'AbCdEfGhIjKlMnO5a5' => 'ABCDEfghijKLMNO',
      'abcdefghijklmnovKv' => 'AbCdEfGhIjKlMnO',
      'abcdefghijklmnoKvK' => 'aBcDeFgHiJkLmNo'
    }
  end

  def to_18_basic_map
    {
      valid_15_chars => valid_18_chars,
      'abcdeFGHIJklmno' => 'abcdeFGHIJklmnoA5A',
      'ABCDEfghijKLMNO' => 'ABCDEfghijKLMNO5A5',
      'AbCdEfGhIjKlMnO' => 'AbCdEfGhIjKlMnOVKV',
      'aBcDeFgHiJkLmNo' => 'aBcDeFgHiJkLmNoKVK',
      'abcdefghijklmno' => 'abcdefghijklmnoAAA',
      'ABCDEFGHIJKLMNO' => 'ABCDEFGHIJKLMNO555'
    }
  end
end
