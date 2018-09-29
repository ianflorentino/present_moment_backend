class SignupOp < Backend::Op
  include Mixins::UserManagementOp
  include Mixins::PasswordManagementOp

  validates :first_name,
            :last_name,
            :email, presence: true

  attr_reader :user

  protected

  def perform
    @user = build_user
    @user.save!

    true
  end

  def build_user
    User.new.tap do |u|
      u.first_name    = first_name
      u.last_name     = last_name
      u.email         = email
      u.password      = detected_password_confirmation
      u.username      = username
    end
  end

end
