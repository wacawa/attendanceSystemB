class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  validates :work_overtime, length: { maximum: 50 }
  validates :overtime_instructor, length: { maximum: 20 }
  
  validate :finished_at_is_invalid_without_a_started_at
  validate :started_at_than_finished_at_fast_if_invalid
  validate :only_started_at_and_only_finished_at_is_invalid
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
  
  def only_started_at_and_only_finished_at_is_invalid
    unless Date.current == worked_on
      errors.add(:started_at, "のみの更新はできません") if started_at.present? && finished_at.blank?
    end
  end
  
end
