class BookingsController < ApplicationController
  before_action :set_booking, only: [ :show, :update, :destroy ]

  def index
    # @bookings = Booking.order(:id)

    # render :index, status: :ok
    if @current_user.admin? || @current_user.super_admin?
      @bookings = Booking.all
    else
      @bookings = @current_user.bookings
    end
  end


  def show
    render :show, status: :ok
  end


  def create
    # @booking = Booking.new(booking_params)
    if @current_user.admin? || @current_user.super_admin?
      @booking = Booking.new(admin_booking_params)
    else
      @booking = @current_user.bookings.new(booking_params)
    end

    if @booking.save
      render :create, status: :created
    else
      render json: @booking.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    if @booking.update(booking_params)
      render :update, status: :ok
    else
      render json: @booking.errors.full_messages, status: :unprocessable_entity
    end
  end


  def destroy
    @booking.destroy

    render :destroy, status: :ok
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    
    def booking_params
      params.require(:booking).permit(:bus_id, :seats)
    end

    def admin_booking_params
      params.require(:booking).permit(:user_id, :bus_id, :seats)
    end
end

