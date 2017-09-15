
class User < ActiveRecord::Base
  validates :full_name, :email, :encrypted_password, { presence: true }
  validates :email, { uniqueness: true }

  def password
    @password ||= BCrypt::Password.new(encrypted_password)
  end

  def password=(plaintext_password)
    @password = BCrypt::Password.create(plaintext_password)
    self.encrypted_password = @password
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
