class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      # splits the path and grabs the string, quieried word, at the end of the url
      item_name = req.path.split("/items/").last
      # goes into our items array and grabs the first item to match the query
      an_item = @@items.find {|e| e.name == item_name}

      # checks if the item returns nil or not foound when looking through our check
      if an_item.nil?
        #
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write an_item.price
      end

    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish
  end

end
