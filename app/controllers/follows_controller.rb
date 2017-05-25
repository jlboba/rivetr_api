class FollowsController < ApplicationController
  # POST /follows/follower_id/followed_id
  def create
    @follow = Follow.create(follower_id: params[:follower_id], followed_id: params[:followed_id]);

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
