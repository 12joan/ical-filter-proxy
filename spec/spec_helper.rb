require 'rspec'
require 'rspec_junit_formatter'
require 'webmock/rspec'
require 'ical_filter_proxy'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true
end

WebMock.disable_net_connect!(allow_localhost: true)
