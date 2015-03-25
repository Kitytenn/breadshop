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
    @steps.map {|s| s.average_time }.reduce(:+)
  end

  def find_ingredient(name:)
    @ingredients.find {|i| i.name.to_s == name.to_s }
  end

  def find_step(name:)
    @steps.find {|s| s.name.to_s == name.to_s }
  end

  def next_step(name: step)
    prev_step = find_step(name: step)
    @steps[@steps.index(prev_step)+1]
  end
  
  private

  def pre_ferment_quantity(ingredient)
    @ingredients.each_with_object([0]) do |ingr, quantity|
      if ingr.formula
        pre_ferment_ingredient = ingr.formula.find_ingredient(name: ingredient.name)
        quantity << ingr.formula.mix_quantity(pre_ferment_ingredient)
      end
    end.reduce(:+)
  end
end
