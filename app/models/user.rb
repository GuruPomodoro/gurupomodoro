class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:trello]

  has_many :team_users
  has_many :team_leaders, -> { where user_type: 'leader' }, class_name: 'TeamUser'
  has_many :teams, through: :team_users
  has_many :owned_teams, class_name: 'Team', through: :team_leaders, source: :team
  has_many :pomodoros

 def self.from_trello(auth)
  user = User.where(email: auth.info.email).first_or_initialize
  user.provider = auth.provider
  user.uid = auth.uid
  user.email = auth.info.email
  user.full_name = auth.info.name
  user.password = Devise.friendly_token[0,20]
  user.trello_token = auth.credentials.token
  user.trello_secret = auth.credentials.secret
  user.skip_confirmation!
  user.save
  user
 end

 def current_pomodoro
   pomodoros.unscoped.where("started_at <= ? AND finished_at >= ?", DateTime.now, DateTime.now).first
 end

 def current_pomodoro_without_break
   pomodoros.where("started_at <= ? AND finished_at >= ?", DateTime.now, DateTime.now).first
 end

 def leader_of(team)
   team.leaders.include?(self)
 end
end
