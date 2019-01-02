class ErrorObject
  attr_reader :key, :payload

  def initialize(key, payload = {})
    @key = key
    @payload = payload
  end

  def ==(other_token)
    (self.key == other_token.key) && (self.payload == other_token.payload)
  end
end
