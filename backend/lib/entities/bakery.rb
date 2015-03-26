require 'entity'

class Bakery < Entity
  attr_accessor :equipment, :batches, :employees

  def can_start_batch?(batch)
    using_equipment = @batches.map(&:using_equipment).flatten
    false if using_equipment.includes?(equipment)
  end
end
