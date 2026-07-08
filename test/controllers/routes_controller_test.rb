require "test_helper"

class RoutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @route = routes(:one)
  end

  test "should get index" do
    get routes_url, as: :json
    assert_response :success
  end

  test "should create route" do
    assert_difference("Route.count") do
      post routes_url, params: { route: { destination: @route.destination, distance: @route.distance, source: @route.source } }, as: :json
    end

    assert_response :created
  end

  test "should show route" do
    get route_url(@route), as: :json
    assert_response :success
  end

  test "should update route" do
    patch route_url(@route), params: { route: { destination: @route.destination, distance: @route.distance, source: @route.source } }, as: :json
    assert_response :success
  end

  test "should destroy route" do
    assert_difference("Route.count", -1) do
      delete route_url(@route), as: :json
    end

    assert_response :no_content
  end
end
