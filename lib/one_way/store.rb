# Stores data as instance variables
# May subscribe to action classes with `.handle_action`
class OneWay::Store
  extend OneWay::Singleton
  extend OneWay::ParentClass

  class << self
    def reset
      super
      descendants.each do |store_class|
        store_class.action_handlers.each do |handler|
          OneWay::Dispatcher.register(handler)
        end
      end
    end

    def reader_method(*method_names)
      method_names.each do |method_name|
        define_singleton_method(method_name) do
          self.instance.send(method_name)
        end
      end
    end

    def action_handlers
      @action_handlers ||= []
    end

    def handle_action(action_class, &block)
      action_handlers << OneWay::Handler.new(store: self, action: action_class, handler: block)
    end
  end
end