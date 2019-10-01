# frozen_string_literal: true

class Post::List < AbstractService
  validates :top, presence: true

  attr_reader :top
  attr_reader :post_data

  def initialize(top:)
    @top = top
    @post_data = []
  end

  def run
    return AbstractService::FailResult.new("list invalid") unless valid?

    Post.order(avg_score: :desc).limit(top).each do |post|
      post_data << { title: post.title, body: post.body }
    end

    AbstractService::SuccesResult.new(post_data)
  end
end
