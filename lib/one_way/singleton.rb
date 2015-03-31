# There's only ever one of these,
# so access the instance via the class.
# Also, it probably has to reset if the app is reloaded.
module OneWay::Singleton
  def instance
    @instance ||= self.new
  end

  def reset
    @instance = nil
  end

  def method_missing(method_name, *args, &block)
    if instance.respond_to?(method_name)
      instance.send(method_name, *args, &block)
    else
      super
    end
  end
end