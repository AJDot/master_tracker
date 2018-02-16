module Tokenable
  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
