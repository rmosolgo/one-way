# One-Way

What if you had Flux on the server, in Ruby?

- Views render HTML based on stores
- Stores are singletons that held values
- Actions are triggered by HTTP post, stores can respond to them
- Actions either render new HTML _or_ re-render the refering view.

You can imagine actions write to a DB. Stores reload initial values from the DB on startup.

- Make-believe API: https://github.com/rmosolgo/one-way/blob/master/spec/support/dummy_app.rb
- You could start up the dummy app with `bundle exec rake serve`.

Rack is hard. Reloading code is hard.


![one-way](https://cloud.githubusercontent.com/assets/2231765/6912484/eb5422aa-d726-11e4-9809-59513357ebf5.gif)
