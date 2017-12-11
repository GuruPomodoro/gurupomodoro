feature 'Create New Team Member', :devise do

  scenario 'trello_tasks' do
    user = FactoryBot.create(:user)
    user.confirm
    signin(user.email, user.password)
    visit 'teams/new'
    fill_in 'team[title]', with: 'GuruPomodoroTeam'
    fill_in 'team[description]', with: 'Test'
    click_button 'Create Team'
    expect(page).to have_content 'Settings'
    click_link 'Settings'
    expect(page).to have_content 'Trello Integration'
    click_button 'Connect to Trello'
    click_button 'Allow'
    expect(page).to have_content 'Settings'
  end


end