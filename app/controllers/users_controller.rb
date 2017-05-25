class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users.to_json(include: [
      { rivs: {include: :replies} },
      :replies,
      { follower_follows: {include: :follower} },
      { followed_follows: {include:
        { followed: {include: :rivs} }
      }},
      { likes: {include: [:riv, :reply]} }
    ]);
  end

  # GET /users/1
  def show
    render json: @user.to_json(include: [
      { rivs: {include: :replies} },
      :replies,
      { follower_follows: {include: :follower} },
      { followed_follows: {include:
        { followed: {include: :rivs} }
      }},
      { likes: {include: [:riv, :reply]} }
    ]);
  end

  # POST /users
  def create

    # checks if username is unique
    notUnique = User.find_by_username(user_params[:username])

    if notUnique
      render json: {error: "Username already taken, please choose another one!"}
    else
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # LOGIN /users/login
  def login
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      render json: {status: 200, user: user}
    else
      render json: {status: 401, message: "Unauthorized"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :display_name, :profile_photo, :language_learning, :language_known, :password_digest, :password)
    end
end
