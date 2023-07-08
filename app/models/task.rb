class Task < ApplicationRecord
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :end_date, presence: true
  validates :status, presence: true

  scope :search_title_status,  -> (params){ where("title LIKE ?", "%#{params[:task][:title]}%").where(status: params[:task][:status]) }
  scope :search_title,  -> (params){ where("title LIKE ?", "%#{params[:task][:title]}%") }
  scope :search_status,  -> (params){ where(status: params[:task][:status]) }
end
