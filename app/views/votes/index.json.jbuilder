json.array!(@votes) do |vote|
  json.extract! vote, :category, :created_at, :name
  json.url vote_url(vote, format: :json)
end
