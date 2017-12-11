class WelcomeController < ApplicationController
  def index
    redirect_to current_team if current_team.present?
  end

  def about
  end
end
