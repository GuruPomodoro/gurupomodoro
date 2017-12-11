describe User do

  before(:each) { @user = User.new(email: 'test@gurupomodo.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'test@gurupomodo.com'
  end

end
