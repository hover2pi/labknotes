class User < ActiveRecord::Base
  # Add new roles to the END of this array!
  ROLES = [:student, :admin, :professor, :ta]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first, :last, :email, :password, :password_confirmation, :remember_me

  has_many :comments

  validates_presence_of :first, :last, :email

  before_create :set_default_role

  def name
    "#{first} #{last}"
  end

  # Define admin?, admin!, etc. methods
  ROLES.each do |r|
    send :define_method, "#{r}?" do
      roles.include? r
    end
    send :define_method, "#{r}!" do
      self.roles = roles << r
      self.type = r.capitalize
    end
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

private

  def set_default_role
    student! if roles.empty?
  end
end
