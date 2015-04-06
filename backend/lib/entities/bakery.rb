require 'entity'

class Bakery < Entity
  attr_accessor :equipment, :batches, :employees

  def can_start_batch?(batch:, time: Time.now)
    used_equipment = @batches.map { |b| b.equipment_used_at(time: time) }.flatten
    used_equipment != equipment
  end
end
