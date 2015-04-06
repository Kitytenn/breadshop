require 'entity'

class TimeRange < Entity
  attr_accessor :min, :max # in minutes
  attr_accessor :active # boolean

  def initialize(data = {})
    super
    @active ||= true
    @max ||= @min
  end

  def average
    (max + min) / 2
  end
end
