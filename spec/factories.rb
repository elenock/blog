# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:login)  { |n| "login#{n}" }
  end

  factory :post do
    sequence(:title)  { |n| "title#{n}" }
    sequence(:body) { |n| "body#{n}" }
    sequence(:ip) { |n| "192.168.0.#{n}" }
    avg_score { 0 }
    score_count { 0 }
    user
  end
end
