json.extract! user_post, :id, :message, :created_at, :updated_at
json.url user_post_url(user_post, format: :json)
