require 'test_helper'

class LotProductsControllerTest < ActionController::TestCase
  setup do
    @lot_product = lot_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lot_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lot_product" do
    assert_difference('LotProduct.count') do
      post :create, :lot_product => @lot_product.attributes
    end

    assert_redirected_to lot_product_path(assigns(:lot_product))
  end

  test "should show lot_product" do
    get :show, :id => @lot_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lot_product.to_param
    assert_response :success
  end

  test "should update lot_product" do
    put :update, :id => @lot_product.to_param, :lot_product => @lot_product.attributes
    assert_redirected_to lot_product_path(assigns(:lot_product))
  end

  test "should destroy lot_product" do
    assert_difference('LotProduct.count', -1) do
      delete :destroy, :id => @lot_product.to_param
    end

    assert_redirected_to lot_products_path
  end
end
