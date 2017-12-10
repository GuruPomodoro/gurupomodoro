class ReportController < ApplicationController
  def personalreport
    @pomodoros = Pomodoro.unscoped.where(user: current_user)
    arr = [0,0,0,0,0,0,0]
    @daily = @pomodoros.group("DATE_TRUNC('day', created_at)").count
    @daily.each do |key, value|
      arr[key.wday] += value
    end

    @has = {Monday:arr[1], Tuesday:arr[2], Wednesday:arr[3], Thursday:arr[4], Friday:arr[5], Saturday:arr[6], Sunday:arr[0]}

    @arr2= []
    @has.each do |key, value|
      @arr2.push({
        day: key,
        hours: value
        })
    end
  end

  def teamreport
    @pomodoros = Pomodoro.unscoped.where(team: current_team)
    teamarr = [0,0,0,0,0,0,0]
    @dailyteam = @pomodoros.group("DATE_TRUNC('day', created_at)").count
    @dailyteam.each do |key, value|
      teamarr[key.wday] += value
    end

    @hasTeam = {Monday:teamarr[1], Tuesday:teamarr[2], Wednesday:teamarr[3], Thursday:teamarr[4], Friday:teamarr[5], Saturday:teamarr[6], Sunday:teamarr[0]}

    @teamarr2= []
    @hasTeam.each do |key, value|
      @teamarr2.push({
        day: key,
        hours: value
        })
    end
  end

end
