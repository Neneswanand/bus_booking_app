class BusesController < ApplicationController
  before_action :set_bus, only: %i[ show update destroy ]

  def index
    # @buses = Bus.all

    @buses = Bus.order(:id)

    render :index, status: :ok
  end


  def show
    render :show, status: :ok
  end


  def create
    @bus = Bus.new(bus_params)

    if @bus.save
      render :create, status: :created
    else
      render json: @bus.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    if @bus.update(bus_params)
      render :update, status: :ok
    else
      render json: @bus.errors.full_messages, status: :unprocessable_entity
    end
  end


  def destroy
    @bus.destroy

    render :destroy, status: :ok
  end

  private
    def set_bus
      @bus = Bus.find(params[:id])
    end

    
    def bus_params
      params.require(:bus).permit(:bus_name, :registration_number, :bus_number, :bus_type, :total_seats, :departure_time, :route_id, :available_seats, :price, amenities: [])
    end
end
