class TeamInvitation < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :team

  validates :to_name, presence: true
  validates :to_email, presence: true

  def is_accepted?
    accepted_at.present?
  end
end
