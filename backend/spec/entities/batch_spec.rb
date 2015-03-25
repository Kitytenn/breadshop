require 'spec_helper'
require 'entities/batch'

describe Batch do
  include_context "steps"
  let(:formula) { Formula.new(steps: @steps) }
  let(:time) { Time.new(2015, 3, 3, 19, 40) }
  
  before(:each) do
    subject.formula = formula
    subject.start_time = Time.new(2015, 3, 3, 19)
  end

  context '#finish_by' do
    it 'shows average finish time' do
      expect(subject.finish_by).to eq(Time.new(2015, 3, 4, 12, 29))
    end
  end

  context '#next_step_at' do
    context 'currently on step' do
      before(:each) do
        allow(Time).to receive(:now) { time }
        subject.update_step(:fold)
      end
      it 'returns remaining time until action needed' do
        expect(subject.next_step_at).to eq(Time.new(2015, 3, 4, 10, 19))
      end
    end
  end
end
