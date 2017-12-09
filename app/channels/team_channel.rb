class TeamChannel < ApplicationCable::Channel
  def subscribed
   stream_for team_channel
  end

  def receive(data)
    ActionCable.server.broadcast(team_channel, data)
  end

  private
  def team_channel
    team = Team.find(params[:room])
  end
end
