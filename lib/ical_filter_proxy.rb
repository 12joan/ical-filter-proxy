require 'rubygems'
require 'bundler/setup'

require 'rack'
require 'open-uri'
require 'icalendar'
require 'yaml'
require 'forwardable'

require_relative 'ical_filter_proxy/calendar'
require_relative 'ical_filter_proxy/filter_rule'
require_relative 'ical_filter_proxy/filterable_event_adapter'

module IcalFilterProxy
  def self.calendars
    config.transform_values do |calendar_config|
      calendar = Calendar.new(calendar_config['ical_url'], calendar_config['api_key'], calendar_config['timezone'])

      calendar_config['rules'].each do |rule|
        calendar.add_rule(rule['field'], rule['operator'], rule['val'])
      end

      calendar
    end
  end

  def self.config
    YAML.safe_load(File.read(config_file_path))
  end

  def self.config_file_path
    File.expand_path('../config.yml', __dir__)
  end
end
