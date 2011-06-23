require 'test_helper'

class SaleProductsControllerTest < ActionController::TestCase
  setup do
    @sale_product = sale_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_product" do
    assert_difference('SaleProduct.count') do
      post :create, :sale_product => @sale_product.attributes
    end

    assert_redirected_to sale_product_path(assigns(:sale_product))
  end

  test "should show sale_product" do
    get :show, :id => @sale_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sale_product.to_param
    assert_response :success
  end

  test "should update sale_product" do
    put :update, :id => @sale_product.to_param, :sale_product => @sale_product.attributes
    assert_redirected_to sale_product_path(assigns(:sale_product))
  end

  test "should destroy sale_product" do
    assert_difference('SaleProduct.count', -1) do
      delete :destroy, :id => @sale_product.to_param
    end

    assert_redirected_to sale_products_path
  end
end
