class TeamInvitation < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :team

  def is_accepted?
    accepted_at.present?
  end
end
