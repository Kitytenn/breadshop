require 'spec_helper'
require 'entities/bakery'
require 'entities/batch'
require 'entities/equipment'
require 'entities/formula'
require 'entities/location'

describe Bakery do
  include_context "steps"
  include_context "formula"
  let(:employee) { Employee.new }
  let(:equipment1) { [Equipment.new(name: :bowl, quantity: 1, step_names: [:autolyze, :mix, :fold]),
                      Equipment.new(name: :oven, quantity: 1, step_names: [:bake]),
                      Equipment.new(name: :banneton, quantity: 3, step_names: [:proof]),
                      Equipment.new(name: :dutch_oven, quantity: 3, step_names: [:bake])] }
  let(:location1) { Location.new(equipment: equipment1, employees: [employee]) }
  let(:employees)  { [Employee.new, Employee.new, Employee.new] }
  let(:equipment2) { [Equipment.new(name: :bowl, quantity: 1, step_names: [:autolyze, :mix, :fold]),
                      Equipment.new(name: :oven, quantity: 1, step_names: [:bake]),
                      Equipment.new(name: :banneton, quantity: 2, step_names: [:proof]),
                      Equipment.new(name: :dutch_oven, quantity: 1, step_names: [:bake])] }
  let(:location2) { Location.new(equipment: equipment2, employees: employees) }
  let(:formula) { Formula.new(steps: @steps, equipment: equipment2) }
  let(:time) { Time.new(2015, 3, 3, 19, 40) }
  let(:batch) { Batch.new(formula: formula, start_time: time) }
  let(:subject) { described_class.new(locations: [location1, location2], batches: [batch]) }
  before(:each) { allow(Time).to receive(:now) { time } }
  
  context '#can_start_batch?' do
    context 'before bake' do
      it 'checks if there are enough resources to start a batch' do
        expect(subject.can_start_batch?(batch: batch, time: Time.new(2015, 3, 4, 12, 10))).to be true
      end
    end
    context 'during bake' do
      it 'checks if there are enough resources to start a batch' do
        expect(subject.can_start_batch?(batch: batch, time: Time.new(2015, 3, 4, 12, 20))).to be false
      end
    end
  end
end
