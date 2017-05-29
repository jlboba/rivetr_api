class FollowsController < ApplicationController
  before_action :set_follow, only: [:destroy]
  wrap_parameters :follow, include: [:follower_id, :followed_id]

  # POST /follows
  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      render json: @follow, status: :created
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /follows/1
  def destroy
    @follow.destroy
  end


  private
    def set_follow
      @follow = Follow.find(params[:follow_id])
    end

    def follow_params
      params.require(:follow).permit(:follower_id, :followed_id);
    end
end
