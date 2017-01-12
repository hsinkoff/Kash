require 'test_helper'

class KashControllerTest < ActionController::TestCase
  test 'index redirects to Kash' do 
  	get :index
  	assert_redirected_to "redirect-route"
  end

  test 'complete' do 
  	get :complete
  	assert_response :success
  	assert_response 200
  end

  test 'callback' do 
  	post :callback
  	assert_response :success
  	assert_response 200
  end

  test 'cancel' do 
  	get :complete
  	assert_response :success
  end
end
