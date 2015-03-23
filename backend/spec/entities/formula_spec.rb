require 'spec_helper'
require 'entities/ingredient'
require 'entities/formula'
require 'entities/step'
require 'time_range'

def create_step(values)
  step = Step.new
  step.name = values[:name]
  time_range = TimeRange.new
  time_range.min = values[:min]
  time_range.max = values[:max]
  step.time_range = time_range
  step
end

describe Formula do
  describe 'quantity calculations' do
    let(:flour) { Ingredient.new(name: 'flour', percentage: 1.00) }
    let(:water) { Ingredient.new(name: 'water', percentage: 0.75) }
    let(:salt) { Ingredient.new(name: 'salt', percentage: 0.022) }
    let(:yeast) { Ingredient.new(name: 'yeast', percentage: 0.004) }
    describe '#mix_quantity' do

      context 'straight doughs' do
        before(:each) do
          subject.total_flour_quantity = 1000
          subject.ingredients = [flour, water, salt, yeast]
        end
        it 'calculates quantity based on percentages' do
          expect(subject.mix_quantity(water)).to eq(750)
        end
      end

      context 'pre-ferment doughs' do
        let(:poolish_water) { Ingredient.new(name: 'water', percentage: 1.00) }
        let(:poolish_formula) { Formula.new(total_flour_quantity: 500, ingredients: [flour, poolish_water, yeast]) }
        let(:poolish) { Ingredient.new(name: 'poolish', percentage: 0.50, formula: poolish_formula) }
        before(:each) do
          subject.total_flour_quantity = 1000
          subject.ingredients = [flour, water, salt, yeast, poolish]
        end
        it 'calculates quantity based on amount of flour in the poolish' do
          expect(subject.mix_quantity(flour)).to eq(500)
        end
        it 'calculates quantity based on amount of water in the poolish' do
          expect(subject.mix_quantity(water)).to eq(250)
        end
      end
    end

    describe '#total_recipe_quantity' do
      context 'pre-ferment doughs' do
        let(:poolish_water) { Ingredient.new(name: 'water', percentage: 1.00) }
        let(:poolish_formula) { Formula.new(total_flour_quantity: 500, ingredients: [flour, poolish_water, yeast]) }
        let(:poolish) { Ingredient.new(name: 'poolish', percentage: 0.50, formula: poolish_formula) }
        before(:each) do
          subject.total_flour_quantity = 1000
          subject.ingredients = [flour, water, salt, yeast, poolish]
        end
        it 'calculates quantity based on amount of flour in the poolish' do
          expect(subject.total_recipe_quantity(flour)).to eq(1000)
        end
        it 'calculates quantity based on amount of water in the poolish' do
          expect(subject.total_recipe_quantity(water)).to eq(750)
        end
      end    
    end
  end
  
  context '#average_time' do
    before(:each) do
      subject.steps = [ create_step({ name: 'autolyze', min: 20, max: 30 }),
                        create_step({ name: 'mix', min: 12*60, max: 14*60 }),
                        create_step({ name: 'fold', min: 60, max: 90 }),
                        create_step({ name: 'divide', min: 3, max: 10 }),
                        create_step({ name: 'shape', min: 5, max: 10 }),
                        create_step({ name: 'proof', min: 60, max: 90 }),
                        create_step({ name: 'bake', min: 40, max: 60 }) ]
    end
    it 'calculates the average preparation time' do
      expect(subject.average_time).to eq(1018)
    end
  end
end
