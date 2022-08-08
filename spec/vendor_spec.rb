require_relative 'spec_helper'

RSpec.describe Vendor do
  context 'Iteration 1' do
    let(:item1) { Item.new({name: 'Peach', price: "$0.75"}) }
    let(:item2) { Item.new({name: 'Tomato', price: '$0.50'}) }
    let(:vendor) { described_class.new("Rocky Mountain Fresh") }

    it 'exists' do
      expect(vendor).to be_a(described_class)
    end

    it '#name' do
      expect(vendor.name).to eq("Rocky Mountain Fresh")
    end

    it '#inventory' do
      expect(vendor.inventory).to eq({})
    end

    it '#check_stock' do
      expect(vendor.check_stock(item1)).to eq(0)
    end

    it '#stock' do
      vendor.stock(item1, 30)

      expect(vendor.inventory).to eq({item1 => 30})
      expect(vendor.check_stock(item1)).to eq(30)

      vendor.stock(item1, 25)

      expect(vendor.check_stock(item1)).to eq(55)

      vendor.stock(item2, 12)

      expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
    end
  end
end