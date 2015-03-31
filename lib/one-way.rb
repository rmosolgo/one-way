require 'active_support/core_ext/hash'
require 'active_support/core_ext/string'
require 'rack'
require 'json'

module OneWay
  autoload(:Action, "one_way/action")
  autoload(:App, "one_way/app")
  autoload(:Dispatcher, "one_way/dispatcher")
  autoload(:Handler, "one_way/handler")
  autoload(:ParentClass, "one_way/parent_class")
  autoload(:Router, "one_way/router")
  autoload(:Singleton, "one_way/singleton")
  autoload(:Store, "one_way/store")
  autoload(:VERSION, "one_way/version")
  autoload(:View, "one_way/view")

  def self.reset
    Dispatcher.reset
    Store.reset
    Router.reset
  end

  def self.serve
    app = OneWay::App.create
    Rack::Handler::WEBrick.run(app)
  end

  def self.route(path, responder_class)
    Router.route(path, responder_class)
  end
end