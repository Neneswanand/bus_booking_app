class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [ :register, :login]
  
  before_action :authorize_admin, only: [ :index ]

  before_action :authorize_super_admin, only: [:destroy]

  before_action :set_user, only: [ :show, :update, :destroy ]


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

    # render :show, status: :ok  
    if @current_user.admin? || @current_user.super_admin?
      @user = User.find(params[:id])
    elsif @current_user.id == params[:id].to_i
      @user = @current_user
    else
      render json: {
        message: "Access Denied!!!!!"
      }, status: :forbidden
    end
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
      
      @token = JsonWebToken.encode(user_id: @user.id)

      render :login, status: :ok
    else
      render json: { 
        message: "Invalid Email or Password!!!!!"
      }, status: :unauthorized         
    end
  end

  def me
    @user = @current_user
    
    render :show
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
