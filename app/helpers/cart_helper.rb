module CartHelper
  def format_price(price)
    number_to_currency(price)
  end

  def time_intervals(start_time, end_time)
    start_time = format_starting_time(transform_to_current_day(start_time))
    end_time = transform_to_current_day(end_time)

    tap_intervals(start_time, end_time)
  end

  def tap_intervals(start_time, end_time)
    if @intervals.nil?
      @intervals = [start_time].tap { |array| array << array.last + 15.minutes while array.last < end_time }
      @intervals = @intervals.map { |time| time.strftime('%H:%M') }
    end

    @intervals
  end

  def format_starting_time(start_time)
    start_time += 1.hour
    start_time = floor_time(Time.current, 15.minutes) if start_time > Time.current.end_of_day
    if Time.current.seconds_since_midnight > start_time.seconds_since_midnight
      start_time = floor_time(Time.current + 45.minutes, 15.minutes)
    end

    start_time
  end

  def transform_to_current_day(time)
    time.change(year: Time.current.year, month: Time.current.month, day: Time.current.day).comparable_time
  end

  def floor_time(time, seconds = 60)
    Time.at((time.to_f / seconds).floor * seconds)
  end
end
