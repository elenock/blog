# frozen_string_literal: true

class AbstractService::SuccesResult
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def fail?
    false
  end

  def success?
    true
  end
end
