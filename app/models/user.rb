class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :type, :headquarter_id
  belongs_to :person
  belongs_to :headquarter
  validates :username, :uniqueness => true

  def active_for_authentication?
    super && validated?
end

  def inactive_message
    if !validated?
      :not_validated
    else
      super # Use whatever other message
    end
  end
end
