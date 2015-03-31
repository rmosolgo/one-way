# Maps routes to renderers (views & actions)
# Also exposes that info (for View#link_to, for example)
class OneWay::Router
  extend OneWay::Singleton

  class Route
    attr_reader :path, :responder_class, :name
    def initialize(path:, responder_class:, name:)
      @path = path
      @responder_class = responder_class
      @name = name
    end
  end

  attr_reader :routes
  def initialize
    @routes = []
  end

  def route(path, responder_class)
    route_name = responder_class.name.sub(/View$/, '').underscore
    routes << Route.new(path: path, name: route_name, responder_class: responder_class)
  end

  def route_for(key, value)
    routes.find {|r| r.send(key) == value } || raise("Route not found for #{key}: #{value} (registered: #{routes.map(&key)})")
  end

  def render(request)
    route = route_for(:path, request.path)
    route.responder_class.render(request)
  end
end