# Kash Integration

[Kash](https://www.withkash.com/) is an payment transfer company that enables companies to recieve ACH payments. 

## Ruby on Rails Integration

This application exposes a method to perform ACH payments using the Kash service.

It exposes three endpoints that are used in the course of payments.  Visiting the root URL of the application will initiate the request by performing API requests and redirecting the user to the Kash servers.

In the process of the flow, just prior to issuing funds, Kash's server will make an API request back to this web applcation's `callback` flow.

If the flow is successful the user will be sent to the `complete` action, otherwise they will be sent to the `cancel` action.

### API request

The callback and cancel URLs are passed along in the initial API request and can be visible in the `app/models/kash.rb` file.  This file performs both the calculation of the API signature as well as the posting of the initial API request to kash.

### Server Key

In the `app/controllers/kash_controller.rb` the `server_key` will need to be replaced with the server key connected to your specific kash account for this to work.

### Controllers

The `app/controllers/kash_controller.rb` performs the logic needed to make the integration work.

### Accessibility

Kash will need to be able to invoke the callback URL directly, and for endpoints like `localhost` that are not exposed through the Internet, Kash will be able to reach the specified endpoint and will fail.  

To test this in action you can either:

* Expose your localhost through a secure tunnel to your localhost using [ngrok](https://ngrok.com/)
* Push to a production environment.  

### Production Setup

This app is production ready and can be shipped to heroku to rapidly test the Kash service integration.
