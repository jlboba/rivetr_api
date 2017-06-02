class RivsController < ApplicationController
  before_action :set_riv, only: [:show, :update, :destroy]

  # GET /rivs
  def index
    @rivs = Riv.all

    render json: @rivs.to_json(include: :replies)
  end

  # GET /rivs/1
  def show
    render json: @riv.to_json(include: {replies: {include: :user}})
  end

  # POST /rivs
  def create
    @riv = Riv.new(riv_params)

    if @riv.save
      render json: @riv, status: :created, location: @riv
    else
      render json: @riv.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rivs/1
  def destroy
    @riv.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_riv
      @riv = Riv.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def riv_params
      params.require(:riv).permit(:content, :likes, :user_id, :photo)
    end
end
