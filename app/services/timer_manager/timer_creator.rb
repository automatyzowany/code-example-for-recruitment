# frozen_string_literal: true

module TimerManager
  # this module will create a new timer
  class TimerCreator
    include Callable

    def initialize(timer, params, current_user)
      @timer = timer
      @p = params
      @current_user = current_user
    end

    def call
      @timer = Timer.new(@p)
      @timer.user_id = @current_user.id
      @timer.is_active = true
      @timer.time_start = DateTime.now
      @timer.time_end = nil
      TimerManager::OtherTimerFinisher.call(@current_user)
      return false unless @timer.save

      @timer
    end
  end
end
