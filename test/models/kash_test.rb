require 'test_helper'

class KashTest < ActiveSupport::TestCase
  test 'check secret key matches' do 
    server_key = "sk_live_xxxx000x00x0000x00x0x0000000x0x"
    params = {x_account_id: "", x_amount: "", x_currency: "USD", x_customer_first_name: "", 
      x_customer_last_name: "", x_customer_phone: "1-###-###-####", x_customer_email: "", 
      x_customer_billing_address1: "## XXXXXX St", x_customer_billing_address2: "Unit ###", 
      x_customer_billing_city: "", x_customer_billing_state: "XX", x_customer_billing_zip: "#####", x_customer_billing_country: "USA", x_test: true, 
      x_url_complete: "http://www.mystore.com/transaction/complete",
      x_url_callback: "http://www.mystore.com/transaction/callback",
      x_url_cancel: "http://www.mystore.com/checkout"
    }

    assert_equal "3038d53ff75a6410b5a60efdcd0535ca0818c04aa3321b56013d3d85191b4846", Kash.compute_signature(params, server_key)
  end

  test 'api_call returns correct response' do 
    params = {x_account_id: "", x_amount: "", x_currency: "USD", x_customer_first_name: "", 
      x_customer_last_name: "", x_customer_phone: "1-###-###-####", x_customer_email: "", 
      x_customer_billing_address1: "## XXXXXX St", x_customer_billing_address2: "Unit ###", 
      x_customer_billing_city: "", x_customer_billing_state: "XX", x_customer_billing_zip: "#####", x_customer_billing_country: "USA", x_test: true, 
      x_url_complete: "http://www.mystore.com/transaction/complete",
      x_url_callback: "http://www.mystore.com/transaction/callback",
      x_url_cancel: "http://www.mystore.com/checkout"
    }
    signature = 'signature'
    k = Kash.api_call(params, signature)
    assert_equal k.to_hash["location"][0], "redirect-route"
    assert_equal k.code, "303"
    assert_equal k.message, "See Other"
  end

  test 'post_to_kash returns correct response' do 
    server_key = "sk_live_xxxx000x00x0000x00x0x0000000x0x"
    params = {x_account_id: "", x_amount: "", x_currency: "USD", x_customer_first_name: "", 
      x_customer_last_name: "", x_customer_phone: "1-###-###-####", x_customer_email: "", 
      x_customer_billing_address1: "## XXXXXX St", x_customer_billing_address2: "Unit ###", 
      x_customer_billing_city: "", x_customer_billing_state: "XX", x_customer_billing_zip: "#####", x_customer_billing_country: "USA", x_test: true, 
      x_url_complete: "http://www.mystore.com/transaction/complete",
      x_url_callback: "http://www.mystore.com/transaction/callback",
      x_url_cancel: "http://www.mystore.com/checkout"
    }
    k = Kash.post_to_kash(params, server_key)
    assert_equal k.to_hash["location"][0], "redirect-route"
    assert_equal k.code, "303"
    assert_equal k.message, "See Other"
  end

end
