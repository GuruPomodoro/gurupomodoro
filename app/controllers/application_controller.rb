class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_team

  def current_team
    if session[:team_id].present?
      if @current_team.present? == false || @current_team.id != session[:team_id]
        @current_team = Team.find session[:team_id]
      else
        @current_team
      end
    else
      @current_team = nil
    end
  end

end
