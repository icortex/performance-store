require 'test_helper'

class ClothTypesControllerTest < ActionController::TestCase
  setup do
    @cloth_type = cloth_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cloth_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cloth_type" do
    assert_difference('ClothType.count') do
      post :create, :cloth_type => @cloth_type.attributes
    end

    assert_redirected_to cloth_type_path(assigns(:cloth_type))
  end

  test "should show cloth_type" do
    get :show, :id => @cloth_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cloth_type.to_param
    assert_response :success
  end

  test "should update cloth_type" do
    put :update, :id => @cloth_type.to_param, :cloth_type => @cloth_type.attributes
    assert_redirected_to cloth_type_path(assigns(:cloth_type))
  end

  test "should destroy cloth_type" do
    assert_difference('ClothType.count', -1) do
      delete :destroy, :id => @cloth_type.to_param
    end

    assert_redirected_to cloth_types_path
  end
end
