# app/controllers/rfps_controller.rb
class RfpsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_buyer, only: [ :new, :create, :edit, :update ]
  before_action :set_rfp, only: [ :show, :edit, :update ]

  def index
    @rfps = if current_user.buyer?
              current_user.rfps
    else
              Rfp.published
    end
  end

  def show
    @interested = current_user.supplier? && current_user.rfp_interests.exists?(rfp: @rfp)
  end

  def new
    @rfp = Rfp.new
  end

  def create
    @rfp = current_user.rfps.build(rfp_params)

    if @rfp.save
      redirect_to @rfp, notice: "RFP was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to rfps_path, alert: "You can only edit your own RFPs." unless @rfp.user == current_user
  end

  def update
    if @rfp.user == current_user && @rfp.update(rfp_params)
      redirect_to @rfp, notice: "RFP was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def interested
    @rfps = current_user.interested_rfps.published
  end

  private

  def set_rfp
    @rfp = Rfp.find(params[:id])
  end

  def rfp_params
    params.require(:rfp).permit(:title, :description, :submission_deadline, :status)
  end

  def ensure_buyer
    unless current_user.buyer?
      redirect_to rfps_path, alert: "Only buyers can create RFPs"
    end
  end
end
