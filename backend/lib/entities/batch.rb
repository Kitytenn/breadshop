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
    @start_time + @formula.average_time
  end
    
  def next_step_at
    if @history.last
      current_step_started = @history.last[@current_step_name]
      current_step_started + @formula.find_step(name: @current_step_name).average_time
    end
  end

  def using_equipment
    return [] if !@formula.equipment
    @formula.equipment.select {|e| e.needed_for_step_name == @current_step_name }
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
end
