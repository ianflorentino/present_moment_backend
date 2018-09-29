class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Overwritten method for authenticating by either username or email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    return unless login
    where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                  { value: login.downcase }]).first
  end

  attr_accessor :login

  def login
    @login || username || email
  end
end
