require 'byebug'

shared_context "steps", a: :b do
  def time_range(min:, max: min, active: true)
    TimeRange.new(min: min*60, max: max*60, active: active)
  end

  def create_step(name:, time_ranges:)
    Step.new(name: name, time_ranges: time_ranges)
  end

  before do
    @steps = [ create_step(name: :autolyze, time_ranges:
                                              [time_range(min: 5),
                                               time_range(min: 20, max: 30, active: false)]),
               create_step(name: :mix, time_ranges:
                                         [time_range(min: 5)]),
               create_step(name: :fold, time_ranges:
                                      [time_range(min: 30, active: false),
                                       time_range(min: 3),
                                       time_range(min: 30, active: false),
                                       time_range(min: 3),
                                       time_range(min: 30, active: false),
                                       time_range(min: 3),
                                       time_range(min: 12*60, max: 14*60, active: false)]),
               create_step(name: :divide, time_ranges:
                                      [time_range(min: 5)]),
               create_step(name: :shape, time_ranges:
                                      [time_range(min: 5)]),
               create_step(name: :proof, time_ranges:
                                      [time_range(min: 60, max: 90)]),
               create_step(name: :bake, time_ranges:
                                          [time_range(min: 40, max: 60)]) ]
  end
end

