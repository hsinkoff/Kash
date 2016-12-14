class KashController < ApplicationController
  def index
    @signature = Kash.compute_signature(test_params, ENV["kash_server_key"])
    @response = Kash.post_to_kash(test_params, @signature)
    # case @response
    # when Net::HTTPSuccess then
    #   @response
    # when Net::HTTPRedirection then
    #   location = @response['location']
    #   redirect_to location
    # else
    #   @response
    # end
  end

  def complete
    
  end

  def callback
  
  end

  def cancel
    
  end

  private

  def test_params
    {
      x_account_id: ENV["kash_account_id"], 
      x_amount: "10.00", 
      x_currency: "USD", 
      x_customer_first_name: "First", 
      x_customer_last_name: "Last", 
      x_customer_phone: "1-800-567-5309", 
      x_customer_email: "FirstLast@thefirehoseproject.com", 
      x_customer_billing_address1: "### S State St", 
      x_customer_billing_address2: "Unit #", 
      x_customer_billing_city: "Chicago", 
      x_customer_billing_state: "IL", 
      x_customer_billing_zip: "60605", 
      x_customer_billing_country: "USA", 
      x_test: true, 
      x_url_complete: complete_url,
      x_url_callback: callback_url,
      x_url_cancel: cancel_url
    }
  end
  
end
