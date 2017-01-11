class KashController < ApplicationController
  def index
    data = test_data(SecureRandom.hex(16))
    @signature = Kash.compute_signature(data, ENV["kash_server_key"])
    @response = Kash.post_to_kash(data, @signature)
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
    puts "COMPLETE"
    puts "THE PARAMS ARE #{params.inspect}"
  end

  def callback
    puts "CALLBACK"
    puts "THE PARAMS ARE #{params.inspect}"
  end

  def cancel
    puts "CANCEL"
    puts "THE PARAMS ARE #{params.inspect}"
  end

  private

  def test_data(id_number)
    {
      x_account_id: ENV["kash_account_id"], 
      x_amount: "11.00", 
      x_currency: "USD", 
      x_customer_first_name: "Second", 
      x_customer_last_name: "Last", 
      x_customer_phone: "1-800-567-5309", 
      x_customer_email: "First@thefirehoseproject.com", 
      x_customer_billing_address1: "500 S State St", 
      x_customer_billing_address2: "Unit 1", 
      x_customer_billing_city: "Chicago", 
      x_customer_billing_state: "IL", 
      x_customer_billing_zip: "60605", 
      x_customer_billing_country: "USA", 
      x_test: true, 
      x_url_complete: complete_url(id_number),
      x_url_callback: callback_url(id_number),
      x_url_cancel: cancel_url(id_number)
    }
  end
  
end
