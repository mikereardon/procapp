class ProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_supplier, except: [ :index, :show ]
  before_action :set_rfp
  before_action :set_proposal, only: [ :show, :edit, :update ]
  before_action :check_interest, only: [ :new, :create ]
  before_action :check_ownership, only: [ :edit, :update ]

  def index
    if current_user.buyer? && @rfp.user == current_user
      # Buyers can only see submitted, under_review, accepted, or rejected proposals
      @proposals = @rfp.proposals.where.not(status: "draft").includes(:user)
    elsif current_user.supplier?
      # Suppliers can see all their own proposals
      @proposals = @rfp.proposals.where(user: current_user)
    else
      redirect_to rfp_path(@rfp), alert: "You don't have permission to view proposals for this RFP"
    end
  end

  def show
    unless can_view_proposal?
      redirect_to rfp_path(@rfp), alert: "You don't have permission to view this proposal"
    end

    @sections = @proposal.proposal_sections.order(position: :asc)

    # Debugging: Log what's happening with sections
    Rails.logger.debug "Found #{@sections.count} sections for proposal #{@proposal.id}"
    @sections.each do |section|
      Rails.logger.debug "Section #{section.title} content present: #{section.content.present?}"
    end

    @line_items = @proposal.line_items
    @total_price = @proposal.total_price
  end

  def new
    @proposal = current_user.proposals.build(rfp: @rfp)

    # Don't save to the database yet, just build in memory
    @sections = ProposalSection::STANDARD_SECTIONS.map do |section_attrs|
      @proposal.proposal_sections.build(
        title: section_attrs[:title],
        position: section_attrs[:position]
      )
    end

    # Build a blank line item
    @proposal.line_items.build

    # Debug log
    Rails.logger.debug "Building new proposal for RFP: #{@rfp.id} (not saved yet)"
  end

  def create
    @proposal = current_user.proposals.build(proposal_params)
    @proposal.rfp = @rfp

    if @proposal.save
      # After saving, ensure each section has content
      @proposal.proposal_sections.each do |section|
        section.update(content: "") if section.content.nil?
      end

      # If no sections were created through params, create the defaults
      if @proposal.proposal_sections.empty?
        ProposalSection.create_defaults_for(@proposal)
      end

      redirect_to rfp_proposal_path(@rfp, @proposal), notice: "Proposal was successfully created."
    else
      # If validation fails, rebuild the sections for the form
      if @proposal.proposal_sections.empty?
        @sections = ProposalSection::STANDARD_SECTIONS.map do |section_attrs|
          @proposal.proposal_sections.build(
            title: section_attrs[:title],
            position: section_attrs[:position]
          )
        end
      else
        @sections = @proposal.proposal_sections.order(position: :asc)
      end

      # Ensure there's at least one line item for the form
      @proposal.line_items.build if @proposal.line_items.empty?

      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @sections = @proposal.proposal_sections.order(position: :asc)

    # If no sections exist (which seems to be the issue), create them
    if @sections.empty?
      ProposalSection.create_defaults_for(@proposal)
      @sections = @proposal.proposal_sections.reload.order(position: :asc)
    end

    @line_items = @proposal.line_items
    @proposal.line_items.build if @proposal.line_items.empty?
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to rfp_proposal_path(@rfp, @proposal), notice: "Proposal was successfully updated."
    else
      @sections = @proposal.proposal_sections.order(position: :asc)
      @line_items = @proposal.line_items
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])

    # Fix: Check status in a more robust way
    is_draft = @proposal.status.nil? || @proposal.status.blank? || @proposal.status == "draft"

    if @proposal.user == current_user && is_draft
      @proposal.destroy
      redirect_to rfp_path(@rfp), notice: "Proposal was successfully deleted."
    else
      redirect_to rfp_proposal_path(@rfp, @proposal),
        alert: "You can only delete draft proposals that you own. Current status: #{@proposal.status || 'nil'}"
    end
  end

  private

  def set_rfp
    @rfp = Rfp.find(params[:rfp_id])
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(
      :title,
      :status,
      proposal_sections_attributes: [ :id, :title, :position, :content, :_destroy ],
      line_items_attributes: [ :id, :description, :quantity, :unit_price, :_destroy ]
    )
  end

  def ensure_supplier
    unless current_user.supplier?
      redirect_to rfp_path(@rfp), alert: "Only suppliers can submit proposals"
    end
  end

  def check_interest
    unless @rfp.interested_suppliers.include?(current_user)
      redirect_to rfp_path(@rfp), alert: "You must register interest before submitting a proposal"
    end
  end

  def check_ownership
    unless @proposal.user == current_user
      redirect_to rfp_proposal_path(@rfp, @proposal), alert: "You can only edit your own proposals"
    end
  end

  def can_view_proposal?
    # Buyers can view proposals for their RFPs
    # Suppliers can only view their own proposals
    @proposal.rfp.user == current_user || @proposal.user == current_user
  end
end
