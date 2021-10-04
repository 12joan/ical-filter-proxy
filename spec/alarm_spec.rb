require 'spec_helper'

RSpec.describe IcalFilterProxy::Alarm do
  describe '.new' do
    it 'accepts options' do
      filter_rule = described_class.new(action: 'DISPLAY', summary: 'Alarm notification', trigger: '-PT30M')

      expect(filter_rule).to be_a(described_class)
      expect(filter_rule.options[:action]).to eq('DISPLAY')
      expect(filter_rule.options[:summary]).to eq('Alarm notification')
      expect(filter_rule.options[:trigger]).to eq('-PT30M')
    end
  end

  describe '#add_to' do
    it 'adds the alarm to the given event' do
      alarm_double = Struct.new(:action, :summary, :trigger).new(nil, nil, nil)

      event_double = Struct.new(:alarm_double) do
        def alarm
          yield alarm_double
        end
      end.new(alarm_double)

      described_class.new(action: 'DISPLAY', summary: 'Alarm notification', trigger: '-PT30M').add_to event_double

      expect(alarm_double.action).to eq('DISPLAY')
      expect(alarm_double.summary).to eq('Alarm notification')
      expect(alarm_double.trigger).to eq('-PT30M')
    end
  end
end
