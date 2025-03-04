# app/controllers/rfp_interests_controller.rb
class RfpInterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_supplier
  before_action :set_rfp

  def create
    @interest = current_user.rfp_interests.build(rfp: @rfp)

    if @interest.save
      redirect_to @rfp, notice: "You have registered interest in this RFP."
    else
      redirect_to @rfp, alert: "Unable to register interest."
    end
  end

  def destroy
    @interest = current_user.rfp_interests.find_by(rfp: @rfp)

    if @interest&.destroy
      redirect_to @rfp, notice: "You have withdrawn your interest."
    else
      redirect_to @rfp, alert: "Unable to withdraw interest."
    end
  end

  private

  def set_rfp
    @rfp = Rfp.published.find(params[:rfp_id])
  end

  def ensure_supplier
    unless current_user.supplier?
      redirect_to rfps_path, alert: "Only suppliers can register interest"
    end
  end
end
