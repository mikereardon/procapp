class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :role, inclusion: { in: %w[buyer supplier] }

  def buyer?
    role == "buyer"
  end

  def supplier?
    role == "supplier"
  end
end
