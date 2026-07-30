class RoutesController < ApplicationController
  before_action :authorize_admin, only: [:create ,:update, :destroy ]
  
  before_action :set_route, only: [ :show ,:update, :destroy ]

  def index
    @routes = Route.order(:id)

    render :index, status: :ok
  end


  def show
    render :show, status: :ok
  end


  def create
    @route = Route.new(route_params)

    if @route.save
      render :create, status: :created
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end


  def search
    source = params[:source]
    destination = params[:destination]

    matching_buses = []

    Route.find_each do |route|
      stops = [ route.source, route.via, route.destination ]
  
      stops = stops.flatten

      source_index = stops.index(source)

      destination_index = stops.index(destination)

      if source_index && destination_index && source_index < destination_index

        matching_buses.concat(route.buses)

        @buses = matching_buses
      end
    end
      render :search, status: :ok
  end


  def update
    if @route.update(route_params)
      render :update, status: :ok, location: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @route.destroy

    render :destroy, status: :ok
  end

  private
    def set_route
      @route = Route.find(params[:id])
    end

    
    def route_params
      params.require(:route).permit(:source, :destination, :distance, via:[])
    end
end


