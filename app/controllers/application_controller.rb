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

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end

end
