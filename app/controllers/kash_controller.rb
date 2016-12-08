class KashController < ApplicationController
  def index
    @signature = Kash.compute_signature(test_params, "our kash server key")
    @response = Kash.post_to_kash(test_params, @signature)
  end

  def complete
    redirect_to root_path
  end

  def callback
    redirect_to root_path
  end

  def cancel
    redirect_to root_path
  end

  private

  def test_params
    {
      x_account_id: "ID", 
      x_amount: "10.00", 
      x_currency: "USD", 
      x_customer_first_name: "First", 
      x_customer_last_name: "Last", 
      x_customer_phone: "1-555-555-5555", 
      x_customer_email: "FirstLast@example.com", 
      x_customer_billing_address1: "## XXXXXX St", 
      x_customer_billing_address2: "Unit ###", 
      x_customer_billing_city: "City", 
      x_customer_billing_state: "XX", 
      x_customer_billing_zip: "#####", 
      x_customer_billing_country: "USA", 
      x_test: true, 
      x_url_complete: complete_path,
      x_url_callback: callback_path,
      x_url_cancel: cancel_path
    }
  end
  
end
