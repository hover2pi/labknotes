class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.professor?
      can :manage, :all
    else
      can :read, :all
      can :manage, Report
    end
  end
end