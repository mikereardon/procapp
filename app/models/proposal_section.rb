# app/models/proposal_section.rb
class ProposalSection < ApplicationRecord
  belongs_to :proposal

  # Use ActionText for rich text content
  has_rich_text :content

  validates :title, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  # Make sure content is initialized
  after_create :initialize_content

  # Default sections that most proposals need
  STANDARD_SECTIONS = [
    { title: "Executive Summary", position: 1 },
    { title: "Approach & Methodology", position: 2 },
    { title: "Timeline", position: 3 },
    { title: "Team & Experience", position: 4 },
    { title: "Additional Information", position: 5 }
  ]

  # Helper to create default sections for a new proposal
  def self.create_defaults_for(proposal)
    STANDARD_SECTIONS.each do |section|
      section = proposal.proposal_sections.create(
        title: section[:title],
        position: section[:position]
      )
      # Explicitly initialize content
      section.update(content: "")
    end
  end

  private

  def initialize_content
    # Ensure content is never nil
    self.content ||= ""
  end
end
