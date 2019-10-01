# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post "post/create" => "posts#create"
    post "score/create" => "scores#create"
    get "post/top" => "posts#top"
    get "post/ip" => "posts#ip"
  end
end
