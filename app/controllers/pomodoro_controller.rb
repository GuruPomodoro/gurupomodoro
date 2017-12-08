class PomodoroController < ApplicationController
  def start
  end

  def begin
  end

  def break_start
  end

  def interrupt
  end

  def finished
  end

  def choose_list
    @list = TrelloList.find(params[:list_id])
    @tasks = @list.trello_tasks
  end
end
