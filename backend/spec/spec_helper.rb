require 'byebug'
require 'active_support/core_ext/numeric/time'
require 'entities/ingredient'
require 'entities/step'

shared_context "steps", a: :b do
  before do
    @steps = [ Step.new(name: :autolyze, time_ranges:
                            [TimeRange.new(min: 5.minutes),
                             TimeRange.new(min: 20.minutes, max: 30.minutes, active: false)]),
               Step.new(name: :mix, time_ranges:
                                         [TimeRange.new(min: 5.minutes)]),
               Step.new(name: :fold, time_ranges:
                                      [TimeRange.new(min: 30.minutes, active: false),
                                       TimeRange.new(min: 3.minutes),
                                       TimeRange.new(min: 30.minutes, active: false),
                                       TimeRange.new(min: 3.minutes),
                                       TimeRange.new(min: 30.minutes, active: false),
                                       TimeRange.new(min: 3.minutes),
                                       TimeRange.new(min: 12.hours, max: 14.hours, active: false)]),
               Step.new(name: :divide, time_ranges:
                                      [TimeRange.new(min: 5.minutes)]),
               Step.new(name: :shape, time_ranges:
                                      [TimeRange.new(min: 5.minutes)]),
               Step.new(name: :proof, time_ranges:
                                      [TimeRange.new(min: 60.minutes, max: 90.minutes)]),
               Step.new(name: :bake, time_ranges:
                                          [TimeRange.new(min: 40.minutes, max: 60.minutes)]) ]
  end
end

shared_context "formula", a: :b do
  let(:flour) { Ingredient.new(name: 'flour', percentage: 1.00) }
  let(:water) { Ingredient.new(name: 'water', percentage: 0.75) }
  let(:salt) { Ingredient.new(name: 'salt', percentage: 0.022) }
  let(:yeast) { Ingredient.new(name: 'yeast', percentage: 0.004) }
end
