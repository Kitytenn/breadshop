require 'spec_helper'
require 'time_range'

describe TimeRange do
  describe '#average' do
    before(:each) do
      subject.min = 5
      subject.max = 10
    end
    it 'should calculate the average time' do
      expect(subject.average).to eq(7)
    end
  end
end
