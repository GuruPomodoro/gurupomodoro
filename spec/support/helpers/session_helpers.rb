module Features
  module SessionHelpers
    def sign_up_with(email, name, password, confirmation)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Full Name', with: password
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end
  end
end
