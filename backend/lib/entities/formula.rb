require 'entity'

class Formula < Entity
  attr_accessor :name, :total_flour_quantity, :steps, :ingredients

  def mix_quantity(ingredient)
    @total_flour_quantity * ingredient.percentage - pre_ferment_quantity(ingredient)
  end

  def total_recipe_quantity(ingredient)
    @total_flour_quantity * ingredient.percentage
  end

  def average_time
    @steps.map {|s| s.time_range.average }.reduce(:+)
  end

  def find_ingredient(ingredient)
    @ingredients.find {|i| i.name == ingredient.name }
  end
  
  private

  def pre_ferment_quantity(ingredient)
    @ingredients.each_with_object([0]) do |ingr, quantity|
      if ingr.formula
        pre_ferment_ingredient = ingr.formula.find_ingredient(ingredient)
        quantity << ingr.formula.mix_quantity(pre_ferment_ingredient)
      end
    end.reduce(:+)
  end
end
