require 'spec_helper'
require 'entities/bakery'
require 'entities/batch'
require 'entities/equipment'
require 'entities/formula'

describe Bakery do
  include_context "steps"
  let(:equipment) { [Equipment.new(name: :oven, step_name: :bake)] }
  let(:formula) { Formula.new(steps: @steps, equipment: equipment) }
  let(:time) { Time.new(2015, 3, 3, 19, 40) }
  let(:batch) { Batch.new(formula: formula, start_time: time) }
  let(:subject) { described_class.new(equipment: equipment, batches: [batch]) }
  
  context '#can_start_batch?' do
    context 'during bake' do
      before(:each) { allow(Time).to receive(:now) { Time.new(2015, 3, 4, 9) } }
      it 'checks if there are enough resources to start a batch' do
        expect(subject.can_start_batch?(batch)).to be false
      end
    end
  end
end
