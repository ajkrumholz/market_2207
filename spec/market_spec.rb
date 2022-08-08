require 'spec_helper'

RSpec.describe Market do
  context 'Iteration 2' do
    let(:market) { Market.new("South Pearl Street Farmers Market") }

    let(:vendor1) { Vendor.new("Rocky Mountain Fresh") }
    let(:vendor2) { Vendor.new("Ba-Nom-a-Nom") }
    let(:vendor3) { Vendor.new("Palisade Peach Shack") }

    let(:item1) { Item.new({name: 'Peach', price: "$0.75"}) }
    let(:item2) { Item.new({name: 'Tomato', price: "$0.50"}) }
    let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
    let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
    
    before(:each) do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)

      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)

      vendor3.stock(item1, 65)
    end

    it 'exists' do
      expect(market).to be_a(described_class)
    end

    it '#name' do
      expect(market.name).to eq("South Pearl Street Farmers Market")
    end

    it '#vendors' do
      expect(market.vendors).to eq([])
    end

    it '#vendor_names' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
      expect(market.vendor_names).to eq([vendor1.name, vendor2.name, vendor3.name])
    end
    
    it '#vendors_that_sell' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
  end

  context "Iteration 3" do
    let(:market) { Market.new("South Pearl Street Farmers Market") }

    let(:vendor1) { Vendor.new("Rocky Mountain Fresh") }
    let(:vendor2) { Vendor.new("Ba-Nom-a-Nom") }
    let(:vendor3) { Vendor.new("Palisade Peach Shack") }

    let(:item1) { Item.new({name: 'Peach', price: "$0.75"}) }
    let(:item2) { Item.new({name: 'Tomato', price: "$0.50"}) }
    let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
    let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }

    before(:each) do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)

      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)

      vendor3.stock(item1, 65)
      vendor3.stock(item3, 10)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
    end

    it '#sorted_item_list' do
      expected = [
        "Banana Nice Cream",
        "Peach",
        "Peach-Raspberry Nice Cream",
        "Tomato"
      ]
      expect(market.sorted_item_list).to eq(expected)
    end

    it '#total_inventory' do
      expected = {
        item1 => {qty: 100, vendors: [vendor1, vendor3]},
        item2 => {qty: 7, vendors: [vendor1]},
        item3 => {qty: 35, vendors: [vendor2, vendor3]},
        item4 => {qty: 50, vendors: [vendor2]}
      }
      expect(market.total_inventory).to eq(expected)
    end


  end
end