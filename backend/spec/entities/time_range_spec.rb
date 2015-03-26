require 'spec_helper'
require 'entities/time_range'

describe TimeRange do
  describe '#time_stats' do
    before(:each) do
      subject.min = 5
      subject.max = 10
    end
    it 'should calculate the average time' do
      expect(subject.average).to eq(7)
    end
    it 'should calculate the maximum time' do
      expect(subject.max).to eq(10)
    end
    it 'should calculate the minimum time' do
      expect(subject.min).to eq(5)
    end
  end
end
