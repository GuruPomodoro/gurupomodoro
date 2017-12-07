class Pomodoro < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :interruption
end
