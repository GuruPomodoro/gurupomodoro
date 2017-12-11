module TeamsHelper
  def team_user_box_class(user, state = nil)
    return 'onPomodoro' if user.current_pomodoro_without_break.present?
    return 'online' if state.present? && !['Logout', 'init'].include?(state)
    return (user == current_user ? 'online' : 'offline')
  end

  def team_user_box_task(user)
    return user.current_pomodoro_without_break&.trello_task&.title.presence || raw('&nbsp;')
  end
end
