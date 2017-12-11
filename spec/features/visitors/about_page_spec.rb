feature 'About page' do
  scenario 'Visit the about page' do
    visit 'about'
    expect(page).to have_content 'About GuruPomodoro'
  end
end
