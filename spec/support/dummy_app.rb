require 'one-way'

# Actions are basically just constants that
# respond to `.trigger`
class IncrementCount < OneWay::Action
end

class AlterCount < OneWay::Action
  params :alter_by
end


# Stores subscribe to actions with `.handle_action`.
# They can fetch an initial value in `#intialize`.
class CountStore < OneWay::Store
  reader_method :value
  attr_reader :value

  def initialize
    @value = 0
  end

  handle_action IncrementCount do
    @value += 1
  end

  handle_action AlterCount do |action|
    @value += action.alter_by
  end
end


# Views read from stores.
# TO DO: Inject some magic that
# makes them aware of the stores they want to track :)
class CountView < OneWay::View
  def render(path, params)
    "<h1> Count: #{CountStore.value}</h1>"
  end
end

# This binds the Dispatcher etc.
OneWay.reset

# Routes go to Views _or_ Actions
OneWay.route("/count", CountView)
OneWay.route("/increment", IncrementCount)