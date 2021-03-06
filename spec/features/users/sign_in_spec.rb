feature 'Sign in', :devise do

  scenario 'user cannot login witout registration' do
    signin('asdasd@asdasd.com', 'asdasdasd')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  scenario 'user can sign in with valid credentials' do
    user = FactoryBot.create(:user)
    user.confirm
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'user cannot sign in with wrong email' do
    user = FactoryBot.create(:user)
    signin('asdasd@asdasd.com', 'asdasdasd')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end


  scenario 'user cannot sign in with wrong password' do
    user = FactoryBot.create(:user)
    signin(user.email, 'asdasd')
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'
  end

end
