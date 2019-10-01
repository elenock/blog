# frozen_string_literal: true

class ::Api::ScoresController < ApplicationController
  def create
    result = Score::Creator.new(
      post_id: params[:post_id],
      level: params[:level],
    ).run

    render_result(result)
  end
end
