module IcalFilterProxy
  module Servers
    class RackApp
      attr_accessor :calendars

      def initialize(calendars)
        self.calendars = calendars
      end

      def call(env)
        request = Rack::Request.new(env)

        if request.path_info == '/healthcheck'
          return [200, { 'content-type' => 'text/plain' }, ['OK']]
        end

        requested_calendar = request.path_info.sub(/^\//, '')
        calendar = calendars[requested_calendar]

        if calendar
          if request.params['key'] == calendar.api_key
            [200, { 'content-type' => 'text/calendar' }, [calendar.filtered_calendar]]
          else
            [403, { 'content-type' => 'text/plain' }, ['Authentication Incorrect']]
          end
        else
          [404, { 'content-type' => 'text/plain' }, ['Calendar not found']]
        end
      end
    end
  end
end
