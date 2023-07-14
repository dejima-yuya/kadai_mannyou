class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }, on: :new
  before_validation { email.downcase! }
  before_update :admin_cannot_update
  before_destroy :user_cannot_destroy

  has_secure_password
  has_many :tasks, dependent: :destroy

  def admin_cannot_update
    user = User.where(admin: true)
    throw :abort if User.where(admin: true).count == 1 && self[:id] == user[0][:id]
  end

  def user_cannot_destroy
    user = User.where(admin: true)
    throw :abort if User.count == 1
  end
end
