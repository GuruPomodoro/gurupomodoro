class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def trello
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_trello(request.env["omniauth.auth"])

    if @user.persisted?
      session[:team_id] = @user.teams.first&.id
      TeamChannel.broadcast_to(
        current_team,
        sent_by: @user.id,
        state: 'Login',
        html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: @user, state: 'Login'})
      )
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "trello") if is_navigational_format?
    else
      session["devise.oauth_provider"] = 'trello'
      # session["devise.oauth_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
