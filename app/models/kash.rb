class Kash < ApplicationRecord

  def self.compute_signature(params, server_key)
    keys = params.keys.find_all {|a| a.match(/\Ax_/) }.sort!
    message = ''
    keys.each do |key|
      if key != 'x_signature'
        message = message + key.to_s + params[key].to_s
      end
    end
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), server_key, message)
  end

  def self.post_to_kash(params, signature)
    uri = URI.parse("https://gateway.withkash.com/")
    request = Net::HTTP::Post.new(uri)
    data = {
      "x_account_id": ENV["kash_account_id"],
      "x_amount": params[:x_amount],
      "x_currency": params[:x_currency],
      "x_customer_first_name": params[:x_customer_first_name], 
      "x_customer_last_name": params[:x_customer_last_name],
      "x_customer_phone": params[:x_customer_phone],
      "x_customer_email": params[:x_customer_email], 
      "x_customer_billing_address1": params[:x_customer_billing_address1],
      "x_customer_billing_address2": params[:x_customer_billing_address2], 
      "x_customer_billing_city": params[:x_customer_billing_city],
      "x_customer_billing_state": params[:x_customer_billing_state], 
      "x_customer_billing_zip": params[:x_customer_billing_zip],
      "x_customer_billing_country": params[:x_customer_billing_country],
      "x_test": "true", 
      "x_url_complete": params[:x_url_complete],
      "x_url_callback": params[:x_url_callback],
      "x_url_cancel": params[:x_url_cancel],
      "x_signature": signature,
    }

    request.set_form_data(data)
    
    puts "\n\n\n\n\n\n"
    puts "THIS IS THE DATA FOR THE HTTP CALL"
    puts uri.inspect
    puts data.inspect
    puts "\n\n\n\n\n\n"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end
    response
  end
end
