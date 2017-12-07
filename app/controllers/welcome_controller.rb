class WelcomeController < ApplicationController
  def index
    redirect_to current_team if current_team
  end

  def about
  end
end
