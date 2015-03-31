class OneWay::View
  class << self
    def render(path, params)
      body = new.render(path, params)
      headers = {
        "Content-Type" => "text/html",
      }
      [200, headers, [body]]
    end
  end
end