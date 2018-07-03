require "json"
require "big"

def BigInt.from_json(pull : JSON::PullParser)
  pull.read_int
  BigInt.new(pull.raw_value)
end

def BigFloat.from_json(pull : JSON::PullParser)
  pull.read_float
  BigFloat.new(pull.raw_value)
end

def BigDecimal.from_json(pull : JSON::PullParser)
  case pull.kind
  when :int
    pull.read_int
    value = pull.raw_value
  when :float
    pull.read_float
    value = pull.raw_value
  else
    value = pull.read_string
  end
  BigDecimal.new(value)
end
