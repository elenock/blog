# frozen_string_literal: true

class Api::PostsController < ApplicationController
  def create
    result = Post::Creator.new(
      title: params[:title],
      body: params[:body],
      ip: params[:ip],
      login: params[:login]
    ).run

    render_result(result)
  end

  def top
    result = Post::List.new(top: params[:top]).run

    render_result(result)
  end

  def ip
    result = Post::Ip.new.run

    render_result(result)
  end
end
