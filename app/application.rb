class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #p req.path.match(/items/)

    if req.path.match(/items/)
      #p req.path
      item = req.path.split("/items/").last
      # p item
      # p @@items

      sought_item = @@items.find do |each_item|
        each_item.name == item
      end

      p sought_item

      unless sought_item == nil
        resp.write sought_item.price
      else
        resp.status = 400
        resp.write("Item not found")
      end

    else
      resp.status = 404
      resp.write("Route not found")
    end
    resp.finish
  end

end
