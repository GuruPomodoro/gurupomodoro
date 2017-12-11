describe Pomodoro do

  before(:each) {
    @user = FactoryBot.create(:user)
    @team = FactoryBot.create(:team)
    @pomodoro = Pomodoro.new
    @pomodoro.user = @user
    @pomodoro.started_at = DateTime.now
    @pomodoro.finished_at = DateTime.now + 25.minutes
    @pomodoro.duration = 25.minutes
    @pomodoro.team = @team
    @pomodoro.is_break = false
    @pomodoro.save!
  }

  subject { @pomodoro }

  it "#user should match" do
    expect(@pomodoro.user).to match @user
  end

  it "#team should match" do
    expect(@pomodoro.team).to match @team
  end

end
