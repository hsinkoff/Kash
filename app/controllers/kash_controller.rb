class KashController < ApplicationController
  def index
    response = Kash.post_to_kash(test_data, server_key)
    redirect_to response.to_hash["location"][0]
  end

  def complete
    # Kash will redirect the user to this action once everything is complete on their end.
    # A user arriving at complete indicates the payment is complete.
    # A user only goes through this action if Kash receives a 200 response from the callback action.
  end

  def callback
    # Kash will make an api call to the callback action once they have okayed the payment.
    # Kash will not complete the processing of the payment until they receive a 200 response from callback.
    # It might make sense to consider using a transaction for the code in this action.
    render plain: "callback", status: 200 
  end

  def cancel
    # Kash will redirect the user to this action if they are not approved by Kash.
    # Kash will redirect the user to this action if Kash does not receive a 200 response from the callback action.
    # Kash will redirect the user to this action if the user clicks cancel.
    # If a user arrives here, a payment was not made.
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
      x_customer_email: "email@example.com", 
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
