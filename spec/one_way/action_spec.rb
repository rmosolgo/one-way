require 'spec_helper'

describe OneWay::Action do
  before do
    CountStore.reset
  end

  it 'can re-render the refering view' do
    fake_request = OpenStruct.new(referer: "/", params: {})
    response = IncrementCount.render(fake_request)
    first_html = response[2][0].split("\n")[1].strip
    assert_equal("<h1>Count: 1</h1>", first_html)
  end

  it 'can render its own view' do
    fake_request = OpenStruct.new(params: {"alter_by" => "-3"})
    response = AlterCount.render(fake_request)
    first_html = response[2][0].split("\n")[1].strip
    assert_equal("<h1>Altered Count: -3</h1>", first_html)
  end
end