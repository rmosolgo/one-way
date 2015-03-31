class OneWay::Router
  attr_reader :routes

  def initialize
    @routes = {}
  end

  def route(path, responder_class)
    routes[path] = responder_class
  end

  def render(method, path, params)
    responder_class = routes[path]
    responder_class.render(path, params)
  end

  class << self
    def reset
      @instance = nil
    end

    def instance
      @instance ||= new
    end

    def routes
      instance.routes
    end

    def route(*args)
      instance.route(*args)
    end

    def render(*args)
      instance.render(*args)
    end
  end
end