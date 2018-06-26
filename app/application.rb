require 'pry'
class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      req_item = req.path.split('/items/').last
      item_names = Item.all.collect{|item| item.name}
      #binding.pry
      if item_names.include?(req_item)
        get_item = Item.all.find{|item| item.name == req_item}
      #  binding.pry
        resp.write get_item.price
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
