feature 'Create New Team', :devise do

  scenario 'user can create new team' do
    user = FactoryBot.create(:user)
    user.confirm
    signin(user.email, user.password)
    visit 'teams/new'
    fill_in 'team[title]', with: 'GuruPomodoroTeam'
    fill_in 'team[description]', with: 'Test'
    click_button 'Create Team'
    expect(page).to have_content 'GuruPomodoroTeam'
    expect(page).to have_content 'GuruPomodoroTeam'
  end


end
