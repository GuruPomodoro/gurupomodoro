class TeamUsersController < ApplicationController
  def destroy
    team_user = TeamUser.find(params[:id])
    team_user.destroy
    redirect_to settings_team_path(current_team)
  end
end
