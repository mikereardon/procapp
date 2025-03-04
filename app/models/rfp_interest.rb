class RfpInterest < ApplicationRecord
  belongs_to :rfp
  belongs_to :user

  validates :rfp_id, uniqueness: { scope: :user_id }
end
