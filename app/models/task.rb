class Task < ApplicationRecord
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
end
