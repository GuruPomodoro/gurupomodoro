feature 'Pomodoro', :devise do

  before(:each) {
      @user = FactoryBot.create(:user)
      @team = FactoryBot.create(:team)
      @user.confirm
      team_user = TeamUser.new
      team_user.team = @team
      team_user.user = @user
      team_user.user_type = 'leader'
      team_user.save!
      @user.reload
      @team.reload
      signin(@user.email, @user.password)
  }

  scenario 'start pomodoro' do
    visit '/pomodoro/start'
    expect(page).to have_content 'Hello'
    click_button 'startpomodoro'
    expect(page).to have_content 'Your Pomodoro will finish in'
  end


  scenario 'distrupt pomodoro' do
    visit '/pomodoro/start'
    click_button 'startpomodoro'
    click_link 'Interrupt'
    expect(page).to have_content 'Oh no'
    fill_in 'reason', with: 'reason'
    click_button 'interruptsubmit'
    expect(page).to have_content 'Hello'
  end


  scenario 'start break' do
    visit '/pomodoro/finished'
    expect(page).to have_content 'Congratulations!'
    click_link '5'
    expect(page).to have_content 'Your Break will finish in'
  end


  scenario 'distrupt break' do
    visit '/pomodoro/finished'
    expect(page).to have_content 'Congratulations!'
    click_link '5'
    expect(page).to have_content 'Your Break will finish in'
    click_link 'startpomodoro'
    expect(page).to have_content 'Hello'
  end


end
