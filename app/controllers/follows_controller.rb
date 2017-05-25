class FollowsController < ApplicationController
  # POST /follows
  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      render json: @follow, status: :created
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  private
    def follow_params
      params.require(:follow).permit(:follower_id, :followed_id);
    end
end
