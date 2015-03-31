require 'spec_helper'

describe OneWay::Store do
  before do
    CountStore.reset
  end

  it 'exposes its value' do
    assert_equal(0, CountStore.value)
  end

  it 'listens for actions' do
    assert_equal(0, CountStore.value)
    IncrementCount.render(OpenStruct.new)
    IncrementCount.render(OpenStruct.new)
    assert_equal(2, CountStore.value)
  end

  it 'handles actions with values' do
    assert_equal(0, CountStore.value)
    AlterCount.render(OpenStruct.new(params: {alter_by: -5}))
    assert_equal(-5, CountStore.value)
    AlterCount.render(OpenStruct.new(params: {alter_by: 10}))
    IncrementCount.render(OpenStruct.new)
    assert_equal(6, CountStore.value)
  end
end