json.set! :message, "OK"
json.set! :votes do
  json.array!(@votes) do |vote|
    json.extract! vote, :category, :created_at, :name
    json.set! :id, vote._id.to_s
  end
end
json.set! :category, params[:category]
json.set! :count, @votes.count
