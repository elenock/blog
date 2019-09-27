# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :ip, presence: true

  has_many :marks
  belong_to :users
end
