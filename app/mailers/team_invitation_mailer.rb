class TeamInvitationMailer < ApplicationMailer
  default from: 'no_contact@gurupomodoro.com'

  def new_invitation_email(team_invitation)
    @team_invitation = team_invitation
    @team = @team_invitation.team
    @user = @team_invitation.from
    mail(to: @team_invitation.to_email, subject: "#{@user.full_name} invited you to #{@team.title} team on GuruPomodoro")
  end

  def invitation_new_user_email(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to GuruPomodoro")
  end
end
