describe Pomodoro do

  before(:each) {
    @user = User.new(email: 'test@gurupomodo.com')
    @pomodoro = Pomodoro.new(user: @user)
  }

  subject { @user }

  it "#user sould match" do
    expect(@pomodoro.user).to match @user
  end

end
