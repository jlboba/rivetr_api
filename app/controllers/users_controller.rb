class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_token, except: [:login, :create, :index, :show, :find_by_username]
  before_action :authorize_user, except: [:login, :create, :index, :show, :find_by_username]
  wrap_parameters :user, include: [:username, :display_name, :profile_photo, :language_learning, :language_known, :password_digest, :password, :biography]

  # GET /users
  def index
    @users = User.all

    render json: @users.to_json(include: [
      { rivs: {include: :replies} },
      { replies: {include: :riv} },
      { follower_follows: {include: :follower} },
      { followed_follows: {include:
        { followed: {include: [:rivs, replies: {include: {riv: {include: :user}}}]} }
      }},
      { likes: {include: [{reply: {include: [:user, {riv: {include: :user}}]}}, {riv: {include: :user}}]}}
    ])
  end

  # GET /users/1
  def show
    render json: @user.to_json(include: [
      { rivs: {include: :replies} },
      { replies: {include: {riv: {include: :user}}} },
      { follower_follows: {include: :follower} },
      { followed_follows: {include:
        { followed: {include: [:rivs, replies: {include: {riv: {include: :user}}}]} }
      }},
      { likes: {include: [{reply: {include: [:user, {riv: {include: :user}}]}}, {riv: {include: :user}}]}}
    ])
  end

  # GET /:username
  def find_by_username
    @username = User.find_by_username(params[:username])

    render json: @username.to_json(include: [
      { rivs: {include: :replies} },
      { replies: {include: {riv: {include: :user}}} },
      { follower_follows: {include: :follower} },
      { followed_follows: {include:
        { followed: {include: [:rivs, replies: {include: {riv: {include: :user}}}]} }
      }},
      { likes: {include: [{reply: {include: [:user, {riv: {include: :user}}]}}, {riv: {include: :user}}]}}
    ])
  end

  # # GET /users/logged/1
  def current_user
    render json: get_current_user
  end

  # POST /users
  def create
    # checks if username is unique
    notUnique = User.find_by_username(user_params[:username])

    if notUnique
      render json: {error: "Username already taken, please choose another one!"}, status: :not_acceptable
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
    # checks if they changed their password
    if params[:password] != nil
      hashed_password = BCrypt::Password.create(params[:password])
      @user.password = hashed_password
    end

    # checks if username exists
    userExists = User.find_by_username(user_params[:username])

    if userExists
      if @user.id === userExists.id
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        render json: {error: "Username already taken, please choose another one!"}, status: :not_acceptable
      end
    else
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
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
      token = create_token(user.id, user.username)
      render json: {status: 200, user: user, token: token}
    else
      render json: {status: 401, message: "incorrect login info, try again!"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # create a jwt
    def create_token(id, username)
      JWT.encode(payload(id, username), ENV['JWT_SECRET'],'HS256')
    end

    def payload(id, username)
      {
        exp: (Time.now + 60.minutes).to_i,
        iat: Time.now.to_i,
        iss: ENV['JWT_ISSUER'],
        user: {
          id: id,
          username: username
        }
      }
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :display_name, :profile_photo, :language_learning, :language_known, :password_digest, :password, :biography)
    end
end
