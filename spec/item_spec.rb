require_relative 'spec_helper'

RSpec.describe Item do
  context 'Iteration 1' do
    let(:item1) { described_class.new({ name: 'Peach', price: '$0.75' }) }
    let(:item2) { described_class.new({ name: 'Tomato', price: '$0.50' }) }

    it 'exists' do
      expect(item1).to be_a(described_class)
    end

    it '#name' do
      expect(item2.name).to eq('Tomato')
    end

    it '#price' do
      expect(item2.price).to eq('$0.50')
    end
  end
end
