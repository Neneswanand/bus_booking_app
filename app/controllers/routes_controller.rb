class RoutesController < ApplicationController
  before_action :set_route, only: %i[ show update destroy ]

  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)

    if @route.save
      render :show, status: :created, location: @route
    else
      render json: @route.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    if @route.update(route_params)
      render :show, status: :ok, location: @route
    else
      render json: @route.errors, status: :unprocessable_content
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def route_params
      params.expect(route: [ :source, :destination, :distance ])
    end
end
