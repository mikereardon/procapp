# app/models/proposal.rb
class Proposal < ApplicationRecord
  before_validation :set_default_status

  belongs_to :rfp
  belongs_to :user

  has_many :proposal_sections, -> { order(position: :asc) }, dependent: :destroy
  has_many :line_items, dependent: :destroy
  # This prepares for attachments but doesn't require implementation yet
  # has_many :attachments, dependent: :destroy

  # Enable nested attributes for dynamic forms
  accepts_nested_attributes_for :proposal_sections, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true
  validates :status, presence: true

  enum status: {
    draft: "draft",
    submitted: "submitted",
    under_review: "under_review",
    accepted: "accepted",
    rejected: "rejected"
  }

  # Calculate total price from line items
  def total_price
    line_items.sum { |item| item.quantity * item.unit_price }
  end

  # Ensure one proposal per supplier per RFP
  validates :rfp_id, uniqueness: { scope: :user_id,
    message: "You have already created a proposal for this RFP" }

  # Ensure user has registered interest
  validate :user_has_registered_interest

  private

  def user_has_registered_interest
    unless rfp.interested_suppliers.include?(user)
      errors.add(:base, "You must register interest in the RFP before submitting a proposal")
    end
  end


  def set_default_status
    self.status ||= "draft"
  end
end
