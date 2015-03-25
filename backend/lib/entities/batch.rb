require 'entity'

class Batch < Entity
  attr_accessor :start_time, :end_time, :formula, :recipe_quantity, :current_step, :history

  def initialize(data = {})
    super
    @history = []
    update_step(@formula.steps.first.name) if @formula
  end

  def formula=(formula)
    @formula = formula
    update_step(@formula.steps.first.name)
  end
  
  def update_step(key)
    @current_step = key
    @history << { @current_step => Time.now }
  end
  
  def finish_by
    @start_time + @formula.average_time
  end
    
  def next_step_at
    current_step_started = @history.last[@current_step]
    current_step_started + @formula.find_step(name: @current_step).average_time
  end
end
