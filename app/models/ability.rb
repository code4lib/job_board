class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
      can :read, Job, published: true
      can :read, Employer do |employer|
        employer.jobs.published.any?
      end

      can :manage, Job, user_id: user.id if user.persisted?
      can :create, Job
    end
  end
end
