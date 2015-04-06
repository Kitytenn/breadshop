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
    
  def step_at(time:, stat_type: :average)
    if @history.last
      delta = (time - last_step_time)
      step = @formula.find_step(name: last_step_name)
      while delta > 0
        delta = delta - step.time_stats(type: stat_type)
        break if delta < 0
        unless step = @formula.next_step(name: step.name)
          return :finished
        end
      end
      step.name
    else
      @formula.steps.first.name
    end
  end

  def using_equipment(step_name: @current_step_name)
    @formula.find_step(name: step_name).equipment
  end

  def equipment_used_at(time:, stat_type: :average)
    step_name = step_at(time: time, stat_type: stat_type)
    using_equipment(step_name: step_name)
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
