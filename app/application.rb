require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item_name_array = Item.all.collect {|item| item.name}
      #binding.pry
      if item_name_array.include?(item_name)
        found_item = Item.all.find {|s| s.name == item_name}
        resp.write found_item.price
        resp.finish
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
