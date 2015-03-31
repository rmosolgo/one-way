require 'spec_helper'

describe OneWay::Router do
  before do
    CountStore.reset
  end

  it 'renders views to HTML' do
    response = OneWay::Router.render(OpenStruct.new(path: "/", params: {}))
    assert_equal(200, response[0])
    assert_instance_of(String, response[2][0])
  end

  it 'triggers actions and returns new HTML' do
    assert_equal(0, CountStore.value)
    response = OneWay::Router.render(OpenStruct.new(path: "/increment", params: {}, referer: "/"))
    assert_equal(1, CountStore.value)
    first_html = response[2][0].split("\n")[1].strip
    assert_equal("<h1>Count: 1</h1>", first_html)
  end
end