# Stores register handlers here.
# Actions ask Dispatcher to dispatch them.
class OneWay::Dispatcher
  extend OneWay::Singleton

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
end