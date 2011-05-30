require 'test_helper'

class FaultiesControllerTest < ActionController::TestCase
  setup do
    @faulty = faulties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faulties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faulty" do
    assert_difference('Faulty.count') do
      post :create, :faulty => @faulty.attributes
    end

    assert_redirected_to faulty_path(assigns(:faulty))
  end

  test "should show faulty" do
    get :show, :id => @faulty.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @faulty.to_param
    assert_response :success
  end

  test "should update faulty" do
    put :update, :id => @faulty.to_param, :faulty => @faulty.attributes
    assert_redirected_to faulty_path(assigns(:faulty))
  end

  test "should destroy faulty" do
    assert_difference('Faulty.count', -1) do
      delete :destroy, :id => @faulty.to_param
    end

    assert_redirected_to faulties_path
  end
end
