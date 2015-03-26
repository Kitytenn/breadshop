require 'entity'
require 'entities/time_range'

class Step < Entity
  attr_accessor :name, :time_ranges, :target_temp, :equipment

  def average_time
    @time_ranges.map(&:average_time).reduce(:+)
  end

  def max_time
    @time_ranges.map(&:max).reduce(:+)
  end
end
