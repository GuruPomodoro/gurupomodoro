class TeamInvitationsController < ApplicationController
  def create
    invitation = current_team.team_invitations.new(team_invitation_params)
    invitation.from = current_user
    TeamInvitationMailer.new_invitation_email(invitation).deliver_now if invitation.save
    redirect_to settings_team_path(current_team)
  end

  def destroy
    invitation = TeamInvitation.find(params[:id])
    invitation.destroy
    redirect_to settings_team_path(current_team)
  end

  def accept
    invitation = TeamInvitation.find(params[:id])
    user = User.find_by_email(invitation.to_email)
    unless user.present?
      user = User.new
      password = Devise.friendly_token[0,20]
      user.email = invitation.to_email
      user.full_name = invitation.to_name
      user.password = password
      user.skip_confirmation!
      user.save
      TeamInvitationMailer.invitation_new_user_email(user, password).deliver_now
    end
    team_user = TeamUser.new
    team_user.team = invitation.team
    team_user.user = user
    team_user.user_type = 'member'
    if team_user.save
      session[:team_id] = invitation.team.id
      invitation.destroy
    end
    sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_invitation_params
    params.fetch(:team_invitation).permit(:to_name, :to_email)
  end
end
