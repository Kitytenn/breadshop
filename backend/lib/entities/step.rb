require 'entity'
require 'entities/time_range'

class Step < Entity
  attr_accessor :name, :time_ranges, :target_temp, :equipment

  def time_stats(type: :average)
    @time_ranges.map(&type).reduce(:+)
  end
end
