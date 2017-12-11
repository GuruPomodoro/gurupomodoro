class PomodoroController < ApplicationController
  def start
    redirect_to pomodoro_during_path if current_user.current_pomodoro.present?
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'New Pomodoro',
      html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'New Pomodoro'})
    )
  end

  def begin
    redirect_to pomodoro_during_path if current_user.current_pomodoro.present?
    pomodoro = Pomodoro.new
    pomodoro.user = current_user
    pomodoro.started_at = DateTime.now()
    pomodoro.finished_at = DateTime.now() + 25.minutes
    pomodoro.duration = 25.minutes
    pomodoro.team = current_team
    pomodoro.is_break = false
    pomodoro.trello_task_id = params[:trello_task_id].presence
    pomodoro.save
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'Pomodoro Start',
      html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'Pomodoro Start'})
    )
    redirect_to pomodoro_during_path
  end

  def during
    @pomodoro = current_user.current_pomodoro
    redirect_to pomodoro_start_path unless @pomodoro.present?
  end

  def break_start
    redirect_to pomodoro_during_path if current_user.current_pomodoro.present?
    pomodoro = Pomodoro.new
    pomodoro.user = current_user
    pomodoro.started_at = DateTime.now()
    pomodoro.finished_at = DateTime.now() + params[:duration].to_i.minutes
    pomodoro.duration = params[:duration].to_i.minutes
    pomodoro.team = current_team
    pomodoro.is_break = true
    pomodoro.save
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'Break Start',
      html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'Break Start'})
    )
    redirect_to pomodoro_during_path
  end

  def interrupt
  end

  def submit_interrupt
    pomodoro = current_user.current_pomodoro
    redirect_to pomodoro_start_path unless pomodoro.present? || !pomodoro.is_break
    interruption = Interruption.create(user: current_user, reason: params[:reason])
    pomodoro.interruption = interruption
    pomodoro.finished_at = DateTime.now
    pomodoro.duration = (pomodoro.finished_at.to_i - pomodoro.started_at.to_i) / 60
    pomodoro.save
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'Pomodoro Interrupt'
    )
    redirect_to pomodoro_start_path
  end

  def interrupt_break
    pomodoro = current_user.current_pomodoro
    redirect_to pomodoro_start_path unless pomodoro.present?
    pomodoro.finished_at = DateTime.now
    pomodoro.duration = (pomodoro.finished_at.to_i - pomodoro.started_at.to_i) / 60
    pomodoro.save
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'Pomodoro Break Interrupt',
      html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'Pomodoro Break Interrupt'})
    )
    redirect_to pomodoro_start_path
  end

  def finished
    redirect_to pomodoro_during_path if current_user.current_pomodoro.present?
    TeamChannel.broadcast_to(
      current_team,
      sent_by: current_user.id,
      state: 'Finished',
      html: ApplicationController.render_with_signed_in_user(current_user, partial: 'teams/user_pomodoro_box', locals: {user: current_user, state: 'Finished'})
    )
  end

  def choose_list
    @list = TrelloList.find(params[:list_id])
    @tasks = @list.trello_tasks
  end
end
