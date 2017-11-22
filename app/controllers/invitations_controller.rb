class InvitationsController < ApplicationController
  def create
    team = Team.find(params[:team_id])
    invitation = team.invitations.new
    invitation.user = current_user
    invitition.to_email = invitation_params.email
    invitition.to_name = invitation_params.name
    respond_to do |format|
      if invitition.save
        format.html { redirect_to root_path, notice: 'Invitation was successfully created.' }
        format.json { render json: invitation, status: :ok }
      else
        format.html { redirect_to root_path, notice: 'Invitation errpr.' }
        format.json { render json: invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    invitation = TeamInvitation.find(params[:invitation_id])
    invitation.accepted_at = Time.now
    invitation.save
  end

  def show
    @invitation = TeamInvitation.find(params[:invitation_id])
  end

  private
  def invitation_params
    params.fetch(:invitation).permit(:email, :name)
  end

end
