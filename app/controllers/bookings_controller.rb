class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update, :destroy]

  before_action :authorize_admin, only: [:show, :update, :destroy]

  def index
    # if @current_user.admin? || @current_user.super_admin?
    #   @bookings = Booking.all
    # else
    #   @bookings = @current_user.bookings
    # end

    if @current_user.user?
      @bookings = @current_user.bookings
    else 
      @bookings = Booking.all
    end
  end


  def show
      render :show, status: :ok
  end


  def create
    # if @current_user.admin? || @current_user.super_admin?
    #   @booking = Booking.new(admin_booking_params)
    # else
    #   @booking = @current_user.bookings.new(booking_params)
    # end

    # if @booking.save
    #   render :create, status: :created
    # else
    #   render json: @booking.errors, status: :unprocessable_entity
    # end

    if @current_user.admin? || @current_user.super_admin?
      @booking = Booking.create!(admin_booking_params)
      render :create, status: :created
    elsif
      @booking = @current_user.bookings.create!(booking_params)
      render :create, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end


  def update
    if @booking.update(booking_params)
      render :update, status: :ok
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
    # if @current_user.admin? || @current_user.super_admin?
    #   Booking.find(params[:id])
    # else
    #   @current_user.bookings.find(params[:id])
    # end
  end


  def destroy
    @booking.destroy

    render :destroy, status: :ok
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
      # if @current_user.admin? || @current_user.super_admin?
      #   Booking.find(params[:id])
      # else
      #   @current_user.bookings.find(params[:id])
      # end
    end

    
    def booking_params
      params.require(:booking).permit(:bus_id, :seats)
    end

    def admin_booking_params
      params.require(:booking).permit(:user_id, :bus_id, :seats)
    end
end

