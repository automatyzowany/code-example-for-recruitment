# frozen_string_literal: true

module TimerManager
  # this module will finish other timers than pushed one
  class OtherTimerFinisher
    include Callable

    def initialize(current_user)
      @current_user = current_user
      @timers = Timer.active_for_current_user?(@current_user.id)
    end

    def call
      @timers.each do |timer|
        timer.is_active = false
        timer.time_end = DateTime.now
        timer.save
      end
    end
  end
end
