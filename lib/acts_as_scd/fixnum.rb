class Fixnum
  def to_ascd_date
    ActsAsScd::Period::DateValue[self].to_date
  end
end