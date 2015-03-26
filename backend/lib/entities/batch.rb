require 'entity'

class Batch < Entity
  attr_accessor :start_time, :end_time, :formula, :recipe_quantity, :current_step_name, :history

  def initialize(data = {})
    @history = []
    super
  end

  def formula=(formula)
    @formula = formula
    update_step(@formula.steps.first.name)
  end
  
  def update_step(key)
    @current_step_name = key
    if !@history.index { |h| h.keys.first == key }
      add_missing_history(key)
    end
  end
  
  def finish_by
    @start_time + @formula.time_stats
  end
    
  def step_at(time: Time.now, stat_type: :average)
    if @history.last
      delta = (time - last_step_time)
      step_name = last_step_name
      while delta > 0
        step = @formula.find_step(name: step_name)
        delta = delta - step.time_stats(type: stat_type)
        # TODO: return :finished if steps are over
        return step.name unless next_step = @formula.next_step(name: step_name)
        step_name = next_step.name
      end
      step.name
    else
      @formula.steps.first.name
    end
  end

  def using_equipment
    return [] if !@formula.equipment
    @formula.equipment.select {|e| e.step_name == @current_step_name }
  end

  def equipment_used_at(time = Time.now)
  end

  private

  def add_missing_history(key)
    while (@history.last && last_step_name != @formula.prev_step(name: key).name) do
      @history << { @formula.next_step(name: last_step_name).name => :unknown }
    end
    @history << { @current_step_name => Time.now }
  end

  def last_step_name
    @history.last.keys.first.to_sym
  end

  def last_step_time
    @history.last.values.first
  end
end
