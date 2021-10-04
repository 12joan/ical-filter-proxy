module IcalFilterProxy
  class Alarm

    attr_accessor :options

    def initialize(options)
      self.options = options
    end

    def add_to(event)
      event.alarm do |a|
        options.each do |option, value|
          a.send("#{option}=", value)
        end
      end
    end
  end
end
