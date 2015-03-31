class OneWay::App
  def self.create
    builder = Rack::Builder.new do
      use Rack::Reloader, 0
      use Rack::ContentLength

      app = proc do |env|
        req = Rack::Request.new(env)
        method = env["REQUEST_METHOD"]
        path = req.path
        params = req.params
        OneWay::Router.render(method, path, params)
      end

      run app
    end

    builder.to_app
  end
end