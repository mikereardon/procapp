class Rfp < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :submission_deadline, presence: true
  validates :status, presence: true

  has_many :rfp_interests, dependent: :destroy
  has_many :interested_suppliers, through: :rfp_interests, source: :user

  enum status: {
    draft: "draft",
    published: "published",
    closed: "closed"
  }

  scope :published, -> { where(status: "published") }
  scope :by_user, ->(user) { where(user_id: user.id) }
end
