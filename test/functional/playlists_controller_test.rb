require 'test_helper'

class PlaylistsControllerTest < ActionController::TestCase
  setup do
    @playlist = playlists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playlists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playlist" do
    assert_difference('Playlist.count') do
      post :create, :playlist => @playlist.attributes
    end

    assert_redirected_to playlist_path(assigns(:playlist))
  end

  test "should show playlist" do
    get :show, :id => @playlist.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @playlist.to_param
    assert_response :success
  end

  test "should update playlist" do
    put :update, :id => @playlist.to_param, :playlist => @playlist.attributes
    assert_redirected_to playlist_path(assigns(:playlist))
  end

  test "should destroy playlist" do
    assert_difference('Playlist.count', -1) do
      delete :destroy, :id => @playlist.to_param
    end

    assert_redirected_to playlists_path
  end
end
