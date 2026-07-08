class UsersController < ApplicationController
  # def register
  #   @user = User.new(user_params)

  #   if @user.save
  #     render :register, status: :created
  #   #   render json: {
  #   #     message: "Registration Successful!"
  #   #   }, status: :created
  #   else
  #     # render  status: :unprocessable_entity
  #     render json: {
  #       errors: @user.errors.full_messages
  #     }, status: :unprocessable_entity
  #   end
  # end


  def register
    @user = User.create!(user_params)

    render :register, status: :created
  end


  def index
    puts @users.class
    @users = User.all 

    # render json: users, status: :ok
  end


  def show
    @user = User.find(params[:id])

    # render json: user, status: :ok
  end


  def edit
    @user = User.find(params[:id]) 
  end


  def update
    @user = User.find(params[:id])

    @user.update!(user_params)
      # render :update 
    render :update
    # else
      # render 'edit'
    #   render json: {
    #     errors: user.errors.full_messages
    #   }, status: :unprocessable_entity
    # end
  end


  def destroy
    @user = User.find(params[:id])

    @user.destroy
    render :destroy

    # redirect_to Users_path

    # render json: {
    #   message: "User Deleted Successfully!"
    # }, status: :ok
  end



  
  private

  def user_params
    params.permit(:name, :email, :password, :role, :phone, :age, :gender)
  end
end
