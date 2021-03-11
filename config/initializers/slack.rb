Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

Slack::Events.configure do |config|
  config.signing_secret = ENV['SLACK_SIGNING_SECRET']
end

