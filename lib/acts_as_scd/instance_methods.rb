module ActsAsScd

  # TODO: replace identity by send(IDENTITY_COLUMN)...

  def current
    self.class.current.where(IDENTITY_COLUMN=>identity).first
  end

  def initial
    self.class.initial.where(IDENTITY_COLUMN=>identity).first
  end

  def at_date(date)
    self.class.find_by_identity_at(identity, date)
  end

  def before_date(date)
    self.class.find_by_identity_before(identity, date)
  end

  def after_date(date)
    self.class.find_by_identity_after(identity, date)
  end

  def at_present
    self.class.find_by_identity_at_present
  end

  def successor
    return nil if effective_to==END_OF_TIME
    self.class.where(identity:identity, effective_from:effective_to).first
  end

  def antecessor
    return nil if effective_from==START_OF_TIME
    self.class.where(identity:identity, effective_to:effective_from).first
  end

  def successors
    return self.class.where('1=0') if effective_to==END_OF_TIME
    self.class.where(identity:identity).where('effective_from>=:date', date: effective_to).reorder('effective_from')
  end

  def antecessors
    return self.class.where('1=0') if effective_from==START_OF_TIME
    self.class.where(identity:identity).where('effective_to<=:date', date: effective_from).reorder('effective_to')
  end

  def history
    self.class.all_of(identity)
  end

  def latest
    self.class.where(identity:identity).reorder('effective_to desc').limit(1).first
  end

  def earliest
    self.class.where(identity:identity).reorder('effective_from asc').limit(1).first
  end

  # the behaviour of this method is a bit different than the class method
  #   while the class method takes a date and terminates the fitting period,
  #   this simply sets a new end date for the current iteration
  def terminate_at(date=nil)
    # todo-matteo: implement check to prevent period overlapping
     date = self.class.effective_date(date || Date.today)
     update_attributes END_COLUMN=>date
  end

  def started?
    effective_from > START_OF_TIME
  end
  alias_method :initiated?, :started?

  def ended?
    effective_to < END_OF_TIME
  end
  alias_method :terminated?, :ended?

  def started_at?(date)
    effective_from < self.class.effective_date(date)
  end
  alias_method :initiated_at?, :started_at?

  def ended_at?(date)
    effective_to <= self.class.effective_date(date)
  end
  alias_method :terminated_at?, :ended_at?

  def effective_period
    Period[effective_from, effective_to]
  end

  def effective_from_date
    case effective_from
    when END_OF_TIME
      raise "Invalid effective_from value: #{END_OF_TIME}"
    else
      Period::DateValue[effective_from].to_date
    end
  end

  def effective_to_date
    case effective_to
    when START_OF_TIME
      raise "Invalid effective_to value #{START_OF_TIME}"
    else
      Period::DateValue[effective_to].to_date
    end
  end

  def initial?
    effective_period.initial?
  end

  def current?
    effective_period.current?
  end

  def past_limited?
    effective_period.past_limited?
  end

  def future_limited?
    effective_period.future_limited?
  end

  def limited?
    effective_period.limited?
  end

  def unlimited?
    effective_period.unlimited?
  end

end
