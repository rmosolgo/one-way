class OneWay::Dispatcher
  def initialize
    @handlers = Hash.new { |hash, key| hash[key] = [] }
  end

  def register(action_class, handler)
    @handlers[action_class] << handler
  end

  def dispatch(action)
    handlers = @handlers[action.class]
    handlers.each do |handler|
      handler.call(action)
    end
    handlers.inject({}) { |memo, handler| memo[handler.store.name] = true; memo}
  end

  class << self
    def instance
      @instance ||= new
    end

    def reset
      @instance = new
    end

    def register(handler)
      instance.register(handler.action, handler)
    end

    def dispatch(action)
      instance.dispatch(action)
    end
  end
end