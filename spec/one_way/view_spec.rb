require 'spec_helper'

describe OneWay::View do
  let(:view) {CountView.new}

  before do
    CountStore.reset
  end

  describe '#render' do
    it 'returns html' do
      response = view.render(OpenStruct.new)
      first_html = response.split("\n")[1].strip
      assert_equal('<h1>Count: 0</h1>', first_html)
    end
  end

  describe '#link_to' do
    it 'renders links' do
      assert_equal "/", view.link_to(:count)
    end
  end
end