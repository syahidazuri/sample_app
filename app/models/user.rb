class User < ApplicationRecord
  validates :name, presence: true, 
    length: {maximum: Settings.validations.name.max_length}

  validates :email, presence: true, 
    length: { maximum: Settings.validations.email.max_length},
    format: { with: Settings.validations.email.regex },
    uniqueness: true
  
  validates :password, presence: true, 
    length: { minimum: Settings.validations.password.min_length }
  
  has_secure_password 
  
  before_save :downcase_email
  
  class << User
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? Bcrypt::Engine::MIN_COST :
                                                  Bcrypt::Engine.cost
      Bcrypt::Password.create string, cost: cost
    end
  end

  private
  
  def downcase_email
    email.downcase!
  end
end
