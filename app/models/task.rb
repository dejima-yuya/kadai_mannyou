class Task < ApplicationRecord
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :end_date, presence: true
  validates :status, presence: true

  scope :search_title_status,  -> (title, status){ where('title LIKE ?',"%#{title}%").where(status: status) }
  scope :search_title,  -> (title){ where('title LIKE ?',"%#{title}%") }
  scope :search_status,  -> (status){ where(status: status) }

  enum priority: { 高: 0, 中: 1, 低: 2 }

  belongs_to :user
end
