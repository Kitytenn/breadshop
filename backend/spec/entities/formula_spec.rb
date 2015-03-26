require 'spec_helper'
require 'entities/ingredient'
require 'entities/formula'
require 'entities/step'
require 'entities/time_range'

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
  
  context '#time_stats' do
    include_context "steps"
    before(:each) { subject.steps = @steps }
    it 'calculates the average preparation time' do
      expect(subject.time_stats).to eq(1049*60)
    end
  end
end
