# frozen_string_literal: true

class AbstractService
  include ActiveModel::Validations

  def success!(data)
    SuccessResult.new(data)
  end

  def failure!(errors)
    FailResult.new(errors)
  end
end
