json.set! :message, "OK"
json.set! :ranking do
  json.array!(@ranking) do |element|
    json.extract! element, :count, :name, :position, :updated_at
  end
end
json.set! :category, params[:category]
