require 'test_helper'

class MisalesControllerTest < ActionController::TestCase
  setup do
    @misale = misales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:misales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create misale" do
    assert_difference('Misale.count') do
      post :create, :misale => @misale.attributes
    end

    assert_redirected_to misale_path(assigns(:misale))
  end

  test "should show misale" do
    get :show, :id => @misale.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @misale.to_param
    assert_response :success
  end

  test "should update misale" do
    put :update, :id => @misale.to_param, :misale => @misale.attributes
    assert_redirected_to misale_path(assigns(:misale))
  end

  test "should destroy misale" do
    assert_difference('Misale.count', -1) do
      delete :destroy, :id => @misale.to_param
    end

    assert_redirected_to misales_path
  end
end
