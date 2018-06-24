class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      #p req.path
      item = req.path.split("/items/").last

      if @@items.include?(item)
        item.price
      else
        resp.write("don't have")
        resp.status = 404
      end

    else
      resp.write("don't have")
      resp.status = 404
    end


  end



end
