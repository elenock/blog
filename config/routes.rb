# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post 'post/create' => 'posts#create'
    post 'score/create' => 'scores#create'
    post 'post/top' => 'posts#top'
  end
end
