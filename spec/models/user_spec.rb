describe User do

  before(:each) { @user = FactoryBot.create(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:full_name) }
  it { should respond_to(:current_pomodoro) }


  it "#user current_pomodoro test" do
    pomodoro = Pomodoro.new
    team = FactoryBot.create(:team)
    pomodoro.user = @user
    pomodoro.team = team
    pomodoro.started_at = DateTime.now
    pomodoro.finished_at = DateTime.now + 25.minutes
    pomodoro.duration = 25.minutes
    pomodoro.is_break = false
    pomodoro.save!
    expect(@user.current_pomodoro).to match pomodoro
  end

  it "#user is_leader true test" do
    pomodoro = Pomodoro.new
    team = FactoryBot.create(:team)
    team.save!

    team_user = TeamUser.new
    team_user.team = team
    team_user.user = @user
    team_user.user_type = 'leader'
    team_user.save!
    expect(@user.leader_of(team.reload)).to be(true)
  end

  it "#user is_leader false test" do
    pomodoro = Pomodoro.new
    team = FactoryBot.create(:team)
    team.save!
    team2 = FactoryBot.create(:team)
    team2.save!
    team_user = TeamUser.new
    team_user.team = team
    team_user.user = @user
    team_user.user_type = 'leader'
    team_user.save!
    expect(@user.leader_of(team2.reload)).to be(false)
  end

end
