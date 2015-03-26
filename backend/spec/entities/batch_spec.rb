require 'spec_helper'
require 'entities/batch'
require 'entities/equipment'
require 'entities/formula'

describe Batch do
  include_context "steps"
  let(:equipment) { [Equipment.new(name: :oven, needed_for_step_name: :bake)] }
  let(:formula) { Formula.new(steps: @steps, equipment: equipment) }
  let(:time) { Time.new(2015, 3, 3, 19, 40) }
  let(:subject) { described_class.new(formula: formula, start_time: time) }

  context '#update_step' do
    it 'updates the history and sets the current step' do
      subject.update_step(:shape)
      expect(subject.current_step_name).to eq(:shape)
      expect(subject.history.length).to eq 5
    end
  end

  context '#using_equipment' do
    it 'shows what equipment is in use' do
      subject.update_step(:bake)
      expect(subject.using_equipment).to eq equipment
    end
  end

  context '#finish_by' do
    it 'shows average finish time' do
      expect(subject.finish_by).to eq(Time.new(2015, 3, 4, 13, 9))
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
