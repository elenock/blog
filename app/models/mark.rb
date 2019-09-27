# frozen_string_literal: true

class Mark < ApplicationRecord
  validates :level, presence: true

  belong_to :posts
end
