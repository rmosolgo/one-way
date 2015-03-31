# Respond to an HTTP request by sending a payload to the dispatcher
# Then render a view.
class OneWay::Action
  attr_reader :view
  def initialize(request)
    @request = request
  end

  def params
    @request.params
  end

  def method_missing(method_name, *args, &block)
    params[method_name.to_s] || raise("method/param not found: #{JSON.dump(method_name)}")
  end

  def render
  end

  def view_strategy
    if self.class.view_class_name.present?
      :own_class
    elsif @request.referer.present?
      :referer
    end
  end

  def view_class
    case view_strategy
    when :own_class
      Object.const_get(self.class.view_class_name)
    when :referer
      route = OneWay::Router.route_for(:path, referer_path)
      route.responder_class
    else
      OneWay::View::NullView
    end
  end

  def referer_path
    @referer_path ||= URI(@request.referer).path
  end

  class << self
    def params(*param_keys)
      @param_keys = param_keys
    end

    def render(request)
      params = request.params
      if !@param_keys.nil?
        params = params.slice(*@param_keys)
      end
      action = new(request)
      OneWay::Dispatcher.dispatch(action)
      action.render
      view_response = action.view_class.render(request)
      if action.view_strategy == :referer
        view_response[2][0] << "<script>window.history.replaceState({}, '', '#{action.referer_path}')</script>"
      end
      view_response
    end

    attr_reader :view_class_name
    def renders_view(view_class_name)
      @view_class_name = view_class_name
    end
  end
end