# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_result(result, ok_status: 200, fail_status: 422)
    if result.success?
      render status: ok_status, json: result.data
    else
      render status: fail_status, json: { errors: result.errors }
    end
  end
end
