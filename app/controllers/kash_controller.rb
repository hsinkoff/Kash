class KashController < ApplicationController
  def index
    signature = Kash.compute_signature(test_data, ENV["kash_server_key"])
    response = Kash.post_to_kash(test_data, signature)
    redirect_to response.to_hash["location"][0]
  end

  def complete
    render text: "complete", status: 200
    # complete tells user that all is good
    # students only see complete if we've already responded with a 200 to the callback
    # this should show the equivalent of the receipt page
  end

  def callback
    render text: "callback", status: 200 
    # place in transaction
    # tells you everything is good on their end
    #(when we get callback mark them as paid)
    # make sure to return valid http response (200) to ensure we are paid
    # once we return valid 200 response, students see complete and we'll be paid
  end

  def cancel
    # students see this if we don't respond with 200 to the callback or if
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
      x_customer_billing_address1: "500 S State St", 
      x_customer_billing_address2: "Unit 1", 
      x_customer_billing_city: "Chicago", 
      x_customer_billing_state: "IL", 
      x_customer_billing_zip: "60605", 
      x_customer_billing_country: "USA", 
      x_test: Rails.env.production? ? "false": "true", 
      x_url_complete: complete_url,
      x_url_callback: callback_url,
      x_url_cancel: cancel_url
    }
  end
  
end
