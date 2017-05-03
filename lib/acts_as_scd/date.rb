class Date
  def is_start_of_time?
    ActsAsScd::Period::DateValue[ActsAsScd::START_OF_TIME].to_date == self
  end

  def is_end_of_time?
    ActsAsScd::Period::DateValue[ActsAsScd::END_OF_TIME].to_date == self
  end
end