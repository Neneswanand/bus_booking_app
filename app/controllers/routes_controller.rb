class RoutesController < ApplicationController
  before_action :authorize_admin, only: [:create ,:update, :destroy ]
  
  before_action :set_route, only: [ :show ,:update, :destroy ]

  def index
    # @routes = Route.all

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

    matching_routes = []

    matching_buses = []

    Route.find_each do |route|
      stops = [ route.source, route.via, route.destination ]
  
      stops = stops.flatten

      source_index = stops.index(source)

      destination_index = stops.index(destination)


      if source_index && destination_index && source_index < destination_index
        matching_routes << route

        matching_buses.concat(route.buses)

        @buses = matching_buses

        @routes = matching_routes
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

#user token - eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMiwiZXhwIjoxNzg1Mjk4ODI0fQ.EPByQefkJyfsQLw33Krh6Kj_NFkPapWlBGxsoGT1DYU

#Expired token - eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNzg0OTU0MzIwfQ.hK5RR65lB01js5jVYJBNF4WthfaztHq-fUnmkhKGP8Q

#super_admin token - eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNzg1MzA5MTEzfQ.jrJKlq__XfTdS2nZ--rRWp-aOzDZswFlRnuMyhB6yns