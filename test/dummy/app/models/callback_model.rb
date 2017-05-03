class CallbackModel < ActiveRecord::Base
  # this model's purpose is to test callbacks
  has_identity :string, limit: 3

  def compute_identity
    self.identity = code
  end

  ### ASSOCIATIONS

  ### CALLBACKS
  # do not use block definition, otherwise the 'return false' would not be allowed
  # the following code would raise the Exception: "LocalJumpError: unexpected return":
  #
  # before_terminate_iteration do
  #   if effective_to_date < Date.today
  #     name << ' aborted'
  #     errors.add(:effective_to_date, I18n.t('errors.messages.invalid')) # this will prevent the model from being persisted
  #     return false # this is not allowed inside blocks
  #   end
  # end
  before_terminate_iteration :check_effective_to

  # since we don't use 'return false', this block definition is allowed
  after_terminate_iteration do
    name << ' after_terminate_identity'
  end

  before_create_iteration :check_effective_from

  # since we don't use 'return false', this block definition is allowed
  after_create_iteration  do
    name << " after_create_iteration there are #{antecessors.size} antecessors"
  end

  def check_effective_to
    if effective_to_date < Date.today
      name << ' aborted'
      errors.add(:effective_to_date, I18n.t('errors.messages.invalid')) # this will prevent the model from being persisted
      return false # this will prevent all other potential callbacks from being run (omit 'return false' if you want the other callbacks to fire)
    end
    name << " before_terminate_identity the original value was #{effective_to_was.to_ascd_date}"
  end

  def check_effective_from
    if effective_from_date < Date.today
      name << ' aborted'
      errors.add(:effective_from_date, I18n.t('errors.messages.invalid')) # this will prevent the model from being persisted
      return false # this will prevent all other potential callbacks from being run (omit 'return false' if you want the other callbacks to fire)
    end
    name << " before_create_iteration the original value was #{effective_from_was.to_ascd_date}"
  end
end
