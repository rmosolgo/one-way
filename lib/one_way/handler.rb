# Just connects a store class, an action class, and some code.
class OneWay::Handler
  attr_reader :store, :action, :handler
  def initialize(store:, action:, handler:)
    @store = store
    @action = action
    @handler = handler
  end

  def call(action)
    store.instance.instance_exec(action, &handler)
  end
end