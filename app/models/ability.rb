class Ability
  include CanCan::Ability

  def initialize(user)
    can :show, Team do |team|
        team.members.include?(user)
    end

    can :edit, Team do |team|
        user.leader_of(team)
    end
  end
end
