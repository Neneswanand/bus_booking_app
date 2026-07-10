class RoutesController < ApplicationController
  before_action :set_route, only: %i[ show update destroy ]

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
      render :create, status: :created, location: @route
    else
      render json: @route.errors, status: :unprocessable_content
    end
  end


  def update
    if @route.update(route_params)
      render :update, status: :ok, location: @route
    else
      render json: @route.errors, status: :unprocessable_content
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
      params.require(:route).permit(:source, :destination, :distance)
    end
end
