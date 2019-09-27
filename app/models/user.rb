# frozen_string_literal: true

class User < ApplicationRecord
  validates :login, presence: true, uniqueness: true

  has_many :posts
end
