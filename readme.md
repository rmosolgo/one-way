# One-Way

What if you had Flux on the server, in Ruby?

- Views rendered HTML based on stores
- Stores were singletons that held values
- Actions were triggered by HTTP post, stores could respond to them
- Responses to those actions notified views what to change

Not much here, just a thought.

Make-believe API: https://github.com/rmosolgo/one-way/blob/master/spec/support/dummy_app.rb

Rack is hard. Reloading code is hard.
