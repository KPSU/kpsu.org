require 'test_helper'

class HandbookPagesControllerTest < ActionController::TestCase
  setup do
    @handbook_page = handbook_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:handbook_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create handbook_page" do
    assert_difference('HandbookPage.count') do
      post :create, :handbook_page => @handbook_page.attributes
    end

    assert_redirected_to handbook_page_path(assigns(:handbook_page))
  end

  test "should show handbook_page" do
    get :show, :id => @handbook_page.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @handbook_page.to_param
    assert_response :success
  end

  test "should update handbook_page" do
    put :update, :id => @handbook_page.to_param, :handbook_page => @handbook_page.attributes
    assert_redirected_to handbook_page_path(assigns(:handbook_page))
  end

  test "should destroy handbook_page" do
    assert_difference('HandbookPage.count', -1) do
      delete :destroy, :id => @handbook_page.to_param
    end

    assert_redirected_to handbook_pages_path
  end
end
