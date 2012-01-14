require 'test_helper'

class CatalogsControllerTest < ActionController::TestCase
  setup do
    @catalog = catalogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalog" do
    assert_difference('Catalog.count') do
      post :create, :catalog => @catalog.attributes
    end

    assert_redirected_to catalog_path(assigns(:catalog))
  end

  test "should show catalog" do
    get :show, :id => @catalog.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalog.to_param
    assert_response :success
  end

  test "should update catalog" do
    put :update, :id => @catalog.to_param, :catalog => @catalog.attributes
    assert_redirected_to catalog_path(assigns(:catalog))
  end

  test "should destroy catalog" do
    assert_difference('Catalog.count', -1) do
      delete :destroy, :id => @catalog.to_param
    end

    assert_redirected_to catalogs_path
  end
end
