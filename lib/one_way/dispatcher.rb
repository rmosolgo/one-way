# Stores register handlers here.
# Actions ask Dispatcher to dispatch them.
class OneWay::Dispatcher
  def initialize
    @handlers = Hash.new { |hash, key| hash[key] = [] }
  end

  def register(handler)
    @handlers[handler.action] << handler
  end

  def dispatch(action)
    handlers = @handlers[action.class.name]
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

    def method_missing(method_name, *args, &block)
      if instance.respond_to?(method_name)
        instance.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end