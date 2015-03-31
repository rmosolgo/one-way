require 'spec_helper'

describe OneWay::Router do
  before do
    CountStore.reset
  end

  it 'renders views to HTML' do
    response = OneWay::Router.render("GET", "/count", {})
    assert_equal(200, response[0])
    assert_instance_of(String, response[2][0])
  end

  it 'triggers actions and returns changes' do
    assert_equal(0, CountStore.value)
    response = OneWay::Router.render("POST", "/increment", {})
    assert_equal(1, CountStore.value)
    assert_equal("{\"CountStore\":true}", response[2][0])
  end
end