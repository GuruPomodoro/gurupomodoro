feature 'Create New Team Member', :devise do

  scenario 'invite' do
    user = FactoryBot.create(:user)
    user.confirm
    signin(user.email, user.password)
    visit 'teams/new'
    fill_in 'team[title]', with: 'GuruPomodoroTeam'
    fill_in 'team[description]', with: 'Test'
    click_button 'Create Team'
    expect(page).to have_content 'Settings'
    click_link 'Settings'
    expect(page).to have_content 'Members'
    fill_in 'team_invitation[to_name]', with: 'John Doe'
    fill_in 'team_invitation[to_email]', with: 'johndoe@gmail.com'
    click_button 'Invite'
    expect(page).to have_content 'John Doe (johndoe@gmail.com)'
  end


end
