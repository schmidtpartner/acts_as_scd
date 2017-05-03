module ActsAsScd
  require 'active_record' unless defined? ActiveRecord

  def self.included(klazz)
    klazz.extend Query
    klazz.extend Callbacks
  end

  module Callbacks
    extend ActiveSupport::Concern

    CALLBACKS = [
        :before_terminate_iteration, :after_terminate_iteration,
        :before_create_iteration, :after_create_iteration
    ]

    included do
      include ActiveModel::Validations::Callbacks

      define_model_callbacks :terminate_iteration, :only => :before
      define_model_callbacks :terminate_iteration, :only => :after
      define_model_callbacks :create_iteration, :only => :before
      define_model_callbacks :create_iteration, :only => :after
    end

  end

  # include the extension
  ActiveRecord::Base.send(:include, ActsAsScd::Callbacks)

end
