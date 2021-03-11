class WebhooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # This is the endpoint Slack will send event data to
  post '/slack' do
    # Grab the body of the request and parse it as JSON
    request_data = JSON.parse(request.body.read)
    # The request contains a `type` attribute
    # which can be one of many things, in this case,
    # we only care about `url_verification` events.
    case request_data['type']
    when 'url_verification'
      # When we receive a `url_verification` event, we need to
      # return the same `challenge` value sent to us from Slack
      # to confirm our server's authenticity.
      request_data['challenge']
    end
  end
end
