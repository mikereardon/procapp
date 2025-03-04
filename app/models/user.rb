class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :role, inclusion: { in: %w[buyer supplier] }


  has_many :rfps, dependent: :destroy
  has_many :rfp_interests, dependent: :destroy
  has_many :interested_rfps, through: :rfp_interests, source: :rfp

  def buyer?
    role == "buyer"
  end

  def supplier?
    role == "supplier"
  end
end
