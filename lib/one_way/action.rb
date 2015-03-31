class OneWay::Action
  extend OneWay::ParentClass

  def initialize(params)
    @params = params
  end

  def method_missing(method_name, *args, &block)
    @params[method_name] || super
  end

  class << self
    def params(*param_keys)
      @param_keys = param_keys
    end

    def trigger(params={})
      if !@param_keys.nil?
        params = params.slice(*@param_keys)
      end
      action = new(params)
      OneWay::Dispatcher.dispatch(action)
    end

    def reset
    end

    def render(path, params)
      changes = trigger(params)
      headers = {
        "Content-Type" => "application/json"
      }
      [200, headers, [JSON.dump(changes)] ]
    end
  end
end