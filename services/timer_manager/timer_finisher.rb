# frozen_string_literal: true

module TimerManager
  # this module will stop the current timer
  class TimerFinisher
    include Callable

    def initialize(timer)
      @timer = timer
    end

    def call
      @timer.is_active = false
      @timer.time_end = DateTime.now
      return false unless @timer.save

      @timer
    end
  end
end
