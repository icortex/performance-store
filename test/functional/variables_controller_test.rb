require 'test_helper'

class VariablesControllerTest < ActionController::TestCase
  setup do
    @variable = variables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:variables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create variable" do
    assert_difference('Variable.count') do
      post :create, :variable => @variable.attributes
    end

    assert_redirected_to variable_path(assigns(:variable))
  end

  test "should show variable" do
    get :show, :id => @variable.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @variable.to_param
    assert_response :success
  end

  test "should update variable" do
    put :update, :id => @variable.to_param, :variable => @variable.attributes
    assert_redirected_to variable_path(assigns(:variable))
  end

  test "should destroy variable" do
    assert_difference('Variable.count', -1) do
      delete :destroy, :id => @variable.to_param
    end

    assert_redirected_to variables_path
  end
end
