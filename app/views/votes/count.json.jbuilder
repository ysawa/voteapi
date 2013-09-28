json.set! :category, params[:category]
json.set! :name, params[:name]
json.set! :count, @votes.count
json.set! :message, "OK"
