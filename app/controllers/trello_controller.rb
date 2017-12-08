require 'trello'

class TrelloController < ApplicationController

  def get_boards
    trello = Trello::Client.new(
      :consumer_key => "6bc8539de4ebe334b2eaf94b52e4159b",
      :consumer_secret => "35a9320829e1b50a2c9681786e3fb7b9629a5dc95523fefc04dd4c722fff8d4e",
      :oauth_token => current_team.leaders.first.trello_token,
      :oauth_token_secret => current_team.leaders.first.trello_secret
    )
    trello_user = trello.find(:member, current_team.leaders.first.uid)
    boards =  trello_user.boards.map{ |board| {title: board.name, id: board.id} }
    current_user.trello_boards = boards
    current_user.save
    redirect_to settings_team_path(current_team)
  end

  def get_lists
    trello = Trello::Client.new(
      :consumer_key => "6bc8539de4ebe334b2eaf94b52e4159b",
      :consumer_secret => "35a9320829e1b50a2c9681786e3fb7b9629a5dc95523fefc04dd4c722fff8d4e",
      :oauth_token => current_user.trello_token,
      :oauth_token_secret => current_user.trello_secret
    )
    trello_board = trello.find(:board, current_team.trello_board_id)
    lists = trello_board.lists
    list_ids = lists.map(&:id)
    current_team.trello_lists
                .with_trello_board_id(current_team.trello_board_id)
                .without_trello_ids(list_ids)
                .update_all(active: false)
    lists.each do |list|
      next if list.closed
      trello_list = current_team.trello_lists.where(trello_id: list.id).first_or_create
      trello_list.trello_board_id = current_team.trello_board_id
      trello_list.title = list.name
      trello_list.active = true
      trello_list.save
    end
  end

  def get_tasks
    @list = TrelloList.find(params[:list_id])
    trello = Trello::Client.new(
      :consumer_key => "6bc8539de4ebe334b2eaf94b52e4159b",
      :consumer_secret => "35a9320829e1b50a2c9681786e3fb7b9629a5dc95523fefc04dd4c722fff8d4e",
      :oauth_token => current_team.leaders.first.trello_token,
      :oauth_token_secret => current_team.leaders.first.trello_secret
    )
    trello_list = trello.find(:list, @list.trello_id)
    tasks = trello_list.cards
    task_ids = tasks.map(&:id)
    @list.trello_tasks.without_trello_ids(task_ids).update_all(active: false)
    tasks.each do |task|
      next if task.closed
      trello_card = @list.trello_tasks.where(trello_id: task.id).first_or_create
      trello_card.title = task.name
      trello_card.team = current_team
      trello_card.active = true
      trello_card.save
    end
    @tasks = @list.trello_tasks
    respond_to do |format|
      format.js { render 'pomodoro/choose_list' }
    end
  end

end
