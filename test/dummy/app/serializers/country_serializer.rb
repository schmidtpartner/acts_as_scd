class CountrySerializer < ActiveModel::Serializer
  attributes :code, :name, :area, :identity, :ascd_effective_from, :ascd_effective_to, :ascd_started_past, :ascd_ended_past

  has_many :cities_at_present, key: :cities_at_present
  has_many :cities_past, key: :cities_past
  has_many :cities_upcoming, key: :cities_upcoming

  def ascd_effective_from
    (object.effective_from_date.is_start_of_time?) ? nil : object.effective_from_date
  end

  def ascd_effective_to
    (object.effective_to_date.is_end_of_time?) ? nil : object.effective_to_date
  end

  def ascd_started_past
    object.started_at?(Date.today)
  end

  def ascd_ended_past
    object.ended_at?(Date.today)
  end
end
