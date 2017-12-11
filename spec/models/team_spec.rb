describe Team do

  before(:each) {
    @team = FactoryBot.create(:team)
  }

  subject { @team }


  it "#team leader test" do
    user = FactoryBot.create(:user)
    team_user = TeamUser.new
    team_user.team = @team
    team_user.user = user
    team_user.user_type = 'leader'
    team_user.save!
    expect(@team.reload.leaders).to include(user)
  end

  it "#team leader test" do
    user = FactoryBot.create(:user)
    team_user = TeamUser.new
    team_user.team = @team
    team_user.user = user
    team_user.user_type = 'leader'
    team_user.save!
    expect(@team.reload.leaders).to include(user)
  end



end
