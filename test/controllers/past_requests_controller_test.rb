require 'test_helper'

class PastRequestsControllerTest < ActionController::TestCase
  setup do
    @past_request = past_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:past_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create past_request" do
    assert_difference('PastRequest.count') do
      post :create, past_request: { received_help: @past_request.received_help, removed_by: @past_request.removed_by, student_id: @past_request.student_id, time_waited: @past_request.time_waited }
    end

    assert_redirected_to past_request_path(assigns(:past_request))
  end

  test "should show past_request" do
    get :show, id: @past_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @past_request
    assert_response :success
  end

  test "should update past_request" do
    patch :update, id: @past_request, past_request: { received_help: @past_request.received_help, removed_by: @past_request.removed_by, student_id: @past_request.student_id, time_waited: @past_request.time_waited }
    assert_redirected_to past_request_path(assigns(:past_request))
  end

  test "should destroy past_request" do
    assert_difference('PastRequest.count', -1) do
      delete :destroy, id: @past_request
    end

    assert_redirected_to past_requests_path
  end
end
