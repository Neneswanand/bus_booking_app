class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]


  def register
    @user = User.create!(user_params)

    render :register, status: :created
  end


  def index
    # @users = User.all 
    @users = User.order(:id)

    render :index, status: :ok
  end


  def show
    # @user = User.find(params[:id])

    render :show, status: :ok         # Rails automatically calls render implicitly behind the scenes.
  end


  def update
    # @user = User.find(params[:id])

    @user.update!(user_params)
  
    render :update
  end


  def destroy
    # @user = User.find(params[:id])

    @user.destroy!
    
    render :destroy
  end


  def login
    @user = User.find_by(email: login_params[:email])

    if @user&.authenticate(login_params[:password]) 
      # render :login, status: :ok
      token = JsonWebToken.encode(
        user_id: @user.id
      )
    else
      render json: { 
        message: "Invalid Email or Password!!!"
      }, status: :unauthorized          #401 User isn't authenticated
    end
  end


  
  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :role, :phone, :age, :gender)
    end

    def login_params
      params.permit(:email, :password)
    end
end
