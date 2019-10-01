# frozen_string_literal: true

class AbstractService::FailResult
  attr_reader :errors

  def initialize(errors)
    @errors = errors
  end

  def fail?
    true
  end

  def success?
    false
  end
end
