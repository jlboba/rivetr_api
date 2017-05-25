require 'test_helper'

class RivsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @riv = rivs(:one)
  end

  test "should get index" do
    get rivs_url, as: :json
    assert_response :success
  end

  test "should create riv" do
    assert_difference('Riv.count') do
      post rivs_url, params: { riv: { content: @riv.content, likes: @riv.likes } }, as: :json
    end

    assert_response 201
  end

  test "should show riv" do
    get riv_url(@riv), as: :json
    assert_response :success
  end

  test "should update riv" do
    patch riv_url(@riv), params: { riv: { content: @riv.content, likes: @riv.likes } }, as: :json
    assert_response 200
  end

  test "should destroy riv" do
    assert_difference('Riv.count', -1) do
      delete riv_url(@riv), as: :json
    end

    assert_response 204
  end
end
