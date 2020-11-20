# frozen_string_literal: true

class ApplicationService
  include ActiveModel::Validations

  attr_accessor :args, :response

  def self.call(*args)
    service = new(*args)
    service.call_in_transaction
    service.returns
  end

  def initialize(args = {})
    self.args = args.with_indifferent_access
  end

  def call_in_transaction
    return unless valid?

    ActiveRecord::Base.transaction(requires_new: true) do
      raise ActiveRecord::Rollback unless call || errors.present?
    end
  end

  def call
    raise NotImplementedError
  end

  def returns
    OpenStruct.new(
      errors: errors,
      response: response,
      success?: success?,
      failure?: failure?
    )
  end

  private

  def add_errors(errors)
    errors.merge!(errors)
  end

  def success?
    !failure?
  end

  def failure?
    errors.present?
  end
end
