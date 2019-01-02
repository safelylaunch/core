# frozen_string_literal: true

class ErrorObject
  attr_reader :key, :payload

  def initialize(key, payload = {})
    @key = key
    @payload = payload
  end

  def ==(other)
    (key == other.key) && (payload == other.payload)
  end
end
