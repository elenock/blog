# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_190_927_145_057) do
  enable_extension 'plpgsql'

  create_table 'marks', force: :cascade do |t|
    t.integer 'level'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_marks_on_post_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.string 'body'
    t.string 'ip'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'login'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'marks', 'posts'
  add_foreign_key 'posts', 'users'
end
