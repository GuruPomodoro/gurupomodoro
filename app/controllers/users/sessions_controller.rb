class Users::SessionsController < Devise::SessionsController
  after_action :set_team, :only => :create
  after_action :clear_team, :only => :destroy
  before_action :logout_team_channel, :only => :destroy

  def set_team
    if current_user.teams.present?
      session[:team_id] = current_user.teams.first.id
      TeamChannel.broadcast_to(
        current_team,
        sent_by: current_user.id,
        state: 'Login',
        html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'Login'})
      )
    end
  end


  def clear_team
    session[:team_id] = nil
  end

  def logout_team_channel
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'Logout',
      html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'Logout'})
    )
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
