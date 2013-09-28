json.set! :message, "OK"
json.set! :category, params[:category]
json.set! :name, params[:name]
json.set! :count, @votes.count
