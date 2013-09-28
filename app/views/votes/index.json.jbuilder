json.array!(@votes) do |vote|
  json.extract! vote, :category, :name, :created_at
  json.url vote_url(vote, format: :json)
end
