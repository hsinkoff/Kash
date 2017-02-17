class KashController < ApplicationController
  def index
    response = Kash.post_to_kash(test_data, server_key)
    # Server key should be kept secure.  Do not put the actual server_key in this file.
    redirect_to response.to_hash["location"][0]
  end

  def complete
    render plain: "complete", status: 200
    # complete tells user that all is good
    # users only see complete if we've already responded with a 200 to the callback
  end

  def callback
    render plain: "callback", status: 200 
    # place everything we need completed in a transaction
    # tells us everything is good on their (Kash's) end
    # make sure to return valid http response (200) to ensure we are paid
    # once we return valid 200 response, users see complete and we'll be paid
  end

  def cancel
    # users see this if we don't respond with 200 to the callback or if
    # Kash does not approve them before that point in time
    # this view should indicate a problem occurred and no payment was made
  end

  private

  def test_data
    {
      x_account_id: ENV["kash_account_id"], 
      x_amount: "11.00", 
      x_currency: "USD", 
      x_customer_first_name: "Second", 
      x_customer_last_name: "Last", 
      x_customer_phone: "1-800-567-5309", 
      x_customer_email: "First@thefirehoseproject.com", 
      x_customer_billing_address1: "500 South Blvd", 
      x_customer_billing_address2: "Unit 1", 
      x_customer_billing_city: "City", 
      x_customer_billing_state: "CA", 
      x_customer_billing_zip: "12345", 
      x_customer_billing_country: "USA", 
      x_test: Rails.env.production? ? "false": "true", 
      x_url_complete: complete_url,
      x_url_callback: callback_url,
      x_url_cancel: cancel_url
    }
  end
  
end
