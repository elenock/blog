# frozen_string_literal: true

class Post::Creator < AbstractService
  validates :title, presence: true
  validates :body, presence: true
  validates :ip, presence: true
  validates :login, presence: true

  attr_reader :title
  attr_reader :body
  attr_reader :ip
  attr_reader :login

  def initialize(title:, body:, ip:, login:)
    @title = title
    @body = body
    @ip = ip
    @login = login
  end

  def run
    return AbstractService::FailResult.new("post invalid") unless valid?

    user = User.find_by(login: login)
    user ||= User.create!(login: login)

    post = user.posts.create!(title: title, body: body, ip: ip, user_id: user.id)

    AbstractService::SuccesResult.new(post)
  end
end
