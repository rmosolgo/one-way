class OneWay::View
  def link_to(view_name, params={})
    path = OneWay::Router.route_for(:name, view_name.to_s).path
    query_string = params.keys.any? ? params.map{|k, v| "#{k}=#{v}"}.join("&") : nil
    [path, query_string].compact.join("?")
  end

  def render(request)
    raise NotImplementedError, "#render should return HTML"
  end

  class << self
    def render(request)
      body = new.render(request)
      headers = {
        "Content-Type" => "text/html",
      }
      [200, headers, [body]]
    end
  end

  class NullView < OneWay::View
    def render(request)
      ""
    end
  end
end