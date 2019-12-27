class JsonWebToken
  SECRET_KEY = 'TEST_BACK_END'

  def self.encode(payload, exp = 1.hour.from_now)
    payload[:exp] = exp.to_i
    [JWT.encode(payload, SECRET_KEY), payload[:exp]]
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end