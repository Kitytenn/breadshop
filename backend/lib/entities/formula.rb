require 'entity'

class Formula < Entity
  attr_accessor :name, :total_flour_quantity, :steps, :ingredients, :equipment

  def mix_quantity(ingredient)
    @total_flour_quantity * ingredient.percentage - pre_ferment_quantity(ingredient)
  end

  def total_recipe_quantity(ingredient)
    @total_flour_quantity * ingredient.percentage
  end

  def time_stats(type: :average)
    @steps.map{ |s| s.send(:time_stats, type: type) }.reduce(:+)
  end

  def find_ingredient(name:)
    @ingredients.find {|i| i.name.to_s == name.to_s }
  end

  def find_step(name:)
    @steps.find {|s| s.name.to_s == name.to_s }
  end

  def next_step(name:)
    @steps[@steps.index(find_step(name: name))+1]
  end
  
  def prev_step(name:)
    @steps[@steps.index(find_step(name: name))-1]
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
