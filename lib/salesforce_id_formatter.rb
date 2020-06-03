require 'salesforce_id_formatter/version'

module SalesforceIdFormatter
  extend self

  InvalidId = Class.new(StandardError)

  def to_18(id)
    raise InvalidId unless valid_id?(id)

    id.size == 15 ? convert_15_to_18(id) : id
  end

  def to_15(id)
    raise InvalidId unless valid_id?(id)

    id.size == 18 ? convert_18_to_15(id) : id
  end

  def valid_id?(id)
    id && [15, 18].include?(id.size) && id.match(/[^a-zA-Z0-9]/).nil?
  end

  private

  def sfdc_base32_to_decimal(char)
    sfdc_base32[char]
  end

  def decimal_to_sfdc_base32(dec)
    Array(sfdc_base32.rassoc(dec)).first
  end

  # sfdc_base32 because base32 isn't a standard
  # and this is salesforce's interpretation of it.
  def sfdc_base32
    @@b32 ||= begin
      hash = {}
      ('A'..'Z').each_with_index {|letter, idx| hash[letter] = idx }
      ('0'..'5').each_with_index {|digit, idx|  hash[digit]  = idx + 26 }
      hash
    end
  end

  def is_upper?(char)
    !(char =~ /[A-Z]/).nil?
  end

  # Algorithm http://salesforce.stackexchange.com/questions/1653/what-are-salesforce-ids-composed-of
  def convert_15_to_18(str)
    bits = str.split('').map{ |char| is_upper?(char) ? '1' : '0' }
    checkdigits = [
      bits[0..4].join.reverse.to_i(2),
      bits[5..9].join.reverse.to_i(2),
      bits[10..14].join.reverse.to_i(2)
    ]

    checkdigits = checkdigits.map {|d| decimal_to_sfdc_base32(d) }.join
    str + checkdigits
  end

  def convert_18_to_15(str)
    # Assume a default of lower-case for each char
    base = str[0..14].downcase.split('')

    # Convert the last 3 chars to their decimal value
    dec = str[-3..-1].upcase.split('').collect { |char| sfdc_base32_to_decimal(char) }

    # Convert the decimal values to their binary value, MSB in the on the 'right' of the string
    bits = dec.map { |d| format('%05b', d.to_i).reverse.split('') }.flatten

    # Finally, upper-case everything with a '1' in the binary string.
    base.zip(bits).map {|char,bit| bit == '1' ? char.upcase : char }.join
  end
end
