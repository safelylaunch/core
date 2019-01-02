class ErrorObject
  attr_reader :key, :payload

  def initialize(key, payload = {})
    @key = key
    @payload = payload
  end
end
