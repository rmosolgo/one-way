require 'one-way'

# Actions are dispatched in response to HTTP requests.
# They pass data though the system and may send a new view back to the client.
class IncrementCount < OneWay::Action
end

class AlterCount < OneWay::Action
  params :alter_by
  renders_view "AlteredCountView"
end


# Stores subscribe to actions with `.handle_action`.
# They can fetch an initial value in `#initialize`.
class CountStore < OneWay::Store
  reader_method :value
  attr_reader :value

  def initialize
    @value = 0
  end

  handle_action "IncrementCount" do
    @value += 1
  end

  handle_action "AlterCount" do |action|
    @value += action.alter_by.to_i
  end
end


# Views read from stores.
# They can link to actions or views.
class CountView < OneWay::View
  def render(request)
    "
    <h1>Count: #{CountStore.value}</h1>
    <p><a href='#{link_to(:increment_count)}'>Increment</a></p>
    <p><a href='#{link_to(:alter_count, alter_by: 3)}'>Alter by 3</a></p>
    <p><a href='#{link_to(:alter_count, alter_by: -10)}'>Alter by -10</a></p>
    "
  end
end

class AlteredCountView < OneWay::View
  def render(request)
    "
    <h1>Altered Count: #{CountStore.value}</h1>
    <p><a href='#{link_to(:count)}'>view count</a></p>
    "
  end
end

# This binds the Dispatcher, reloads Stores etc.
OneWay.reset

# Routes go to Views _or_ Actions
OneWay.route("/", CountView)
OneWay.route("/increment", IncrementCount)
OneWay.route("/alter", AlterCount)