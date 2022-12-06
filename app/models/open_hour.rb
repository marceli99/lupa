class OpenHour < ApplicationRecord
  validate :open_hours_compatibility

  def verbose_day_of_week
    Date::DAYNAMES[day_of_week % 7]
  end

  def parsed_close_time
    close_time.strftime('%H:%M')
  end

  def parsed_open_time
    open_time.strftime('%H:%M')
  end

  def self.todays_open_hours
    OpenHour.find_by!(day_of_week: DateTime.current.wday)
  end

  def self.is_open?
    open_hour = OpenHour.find_by!(day_of_week: DateTime.current.wday)

    start_minutes = open_hour.open_time.hour * 60 + open_hour.open_time.min
    end_minutes = open_hour.close_time.hour * 60 + open_hour.close_time.min
    current_minutes = Time.current.hour * 60 + Time.current.min

    return true if start_minutes <= current_minutes && current_minutes <= end_minutes

    false
  end

  private

  def open_hours_compatibility
    if open_time > close_time
      self.errors.add(:open_time, 'Must be lower than close time.')
    end
  end
end
