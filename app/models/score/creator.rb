# frozen_string_literal: true

class Score::Creator < AbstractService
  validates :level, presence: true

  attr_reader :post_id
  attr_reader :level

  def initialize(post_id:, level:)
    @post_id = post_id
    @level = level
  end

  def run
    return AbstractService::FailResult.new('score invalid') unless valid?

    post = Post.find_by(id: post_id)
    return AbstractService::FailResult.new('post_does_not_exist') unless post

    ActiveRecord::Base.with_advisory_lock("create-score-level-for-post-id-#{post.id}") do
      ActiveRecord::Base.transaction do
        score = post.scores.create(post_id: post.id, level: level)
        post_update!(score)
      end
    end
    post = Post.find_by(id: post_id)
    AbstractService::SuccesResult.new(post.avg_score)
  end

  def post_update!(score)
    post = Post.find_by(id: score.post_id)
    post.update(
      avg_score: (post.avg_score * post.score_count + score.level) /
                    (post.score_count + 1),
      score_count: (post.score_count + 1)
    )
  end
end
