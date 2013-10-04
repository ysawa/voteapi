json.set! :message, "OK"
json.set! :vote do
  json.extract! @vote, :category, :created_at, :id, :name
  json.set! :id, @vote._id.to_s
end
json.set! :callback, params[:callback]
