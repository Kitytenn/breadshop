class TimeRange
  attr_accessor :min, :max # in minutes

  def average
    (max + min) / 2
  end
end
