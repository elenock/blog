# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :scores
  belongs_to :user
end
