class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:register, :login]
  
  before_action :authorize_admin, only: [:index ]

  before_action :authorize_super_admin, only: [:destroy]

  before_action :set_user, only: [:show, :update, :destroy]


  def register
    @user = User.create!(user_params)

    render :register, status: :created
  end


  def index
    @users = User.order(:id)

    render :index, status: :ok
  end


  def show  
    if @current_user.admin? || @current_user.super_admin?
      @user = User.find(params[:id])
      render :show
    elsif @current_user.id == params[:id].to_i
      @user = @current_user
      render :show
    else
      render json: {
        message: "Access Denied!!!"
      }, status: :forbidden
    end
  end


  def update
    if @current_user.id == params[:id].to_i
      @user.update!(user_params)
    
      render :update
    else
      render json: {
        message: "Access Denied..."
      }
    end
  end


  def destroy
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


  def profile
    @user = @current_user
    
    render :profile
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
