json.set! :votes do
  json.array!(@votes) do |vote|
    json.extract! vote, :category, :created_at, :name
  end
end
json.set! :category, params[:category]
json.set! :count, @votes.count
json.set! :message, "OK"
