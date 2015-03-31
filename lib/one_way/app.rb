# A thing that maps Rack requests to the Router
class OneWay::App
  def self.create
    builder = Rack::Builder.new do
      use Rack::Reloader, 0
      use Rack::ContentLength

      app = proc do |env|
        request = Rack::Request.new(env)
        OneWay::Router.render(request)
      end

      run app
    end

    builder.to_app
  end
end