module OneWay::Singleton
  def instance
    @instance ||= self.new
  end
  def reset
    @instance = nil
  end
end