require 'entity'

class TimeRange < Entity
  attr_accessor :min, :max # in minutes
  attr_accessor :active # boolean

  def average_time
    (max + min) / 2
  end
end
