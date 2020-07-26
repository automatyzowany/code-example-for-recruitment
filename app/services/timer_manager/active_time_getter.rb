# frozen_string_literal: true

module TimerManager
  # this module will get active timer time and place it into timer / index view
  class ActiveTimeGetter
    include Callable

    def initialize(current_user)
      @current_user = current_user
      @active_timer = Timer.active_for_current_user?(@current_user.id)
      @current_time = DateTime.now
    end

    def call
      array = []
      @active_timer.each do |item|
        time_start = DateTime.parse(item.time_start.to_s)
        seconds = ((@current_time - time_start) * 24 * 60 * 60).to_i
        array = time_array(seconds)
      end
      return [0, 0, 0] if array.empty?

      array
    end

    private

    def time_array(seconds)
      hour = Time.at(seconds).utc.strftime('%H')
      minute = Time.at(seconds).utc.strftime('%M')
      second = Time.at(seconds).utc.strftime('%S')
      [] << hour << minute << second
    end
  end
end
