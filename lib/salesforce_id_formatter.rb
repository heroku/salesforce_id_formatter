require "salesforce_id_formatter/version"

module SalesforceIdFormatter
  extend self

  InvalidId = Class.new(StandardError)

  def to_18(id)
    raise InvalidId unless valid_id?(id)

    id.size == 15 ? convert_15_to_18(id) : id
  end

  def to_15(id)
    raise InvalidId unless valid_id?(id)

    id.size == 18 ? id[0..14] : id
  end

  def valid_id?(id)
    [15, 18].include?(id.size) && id.match(/[^a-zA-Z0-9]/).nil?
  end

  private

  def decimal_to_base_32(dec)
    Array(base32.rassoc(dec)).first
  end

  def base32
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
    checkdigits = checkdigits.map {|d| decimal_to_base_32(d) }.join
    str + checkdigits
  end
end
