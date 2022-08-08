require 'spec_helper'

RSpec.describe Market do
  let(:market) { Market.new("South Pearl Street Farmers Market") }

  let(:vendor1) { Vendor.new("Rocky Mountain Fresh") }
  let(:vendor2) { Vendor.new("Ba-Nom-a-Nom") }
  let(:vendor3) { Vendor.new("Palisade Peach Shack") }

  let(:item1) { Item.new({name: 'Peach', price: "$0.75"}) }
  let(:item2) { Item.new({name: 'Tomato', price: "$0.50"}) }
  let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
  let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
  let(:item5) { Item.new({name: 'Onion', price: '$0.25'}) }

  context 'Iteration 2' do
    
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

    it '#overstocked_items' do
      expect(market.overstocked_items).to eq([item1])
    end
  end

  context 'Iteration 4' do
    
    before(:each) do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)

      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)

      vendor3.stock(item1, 65)

      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
    end

    it '#date' do
      expect(market.date).to eq(Date.today.strftime("%d/%m/%Y"))
    end
    
    it '#sell' do
      expect(market.sell(item1, 200)).to eq(false)
      expect(market.sell(item5, 1)).to eq(false)
      expect(market.sell(item4, 5)).to eq(true)
      expect(vendor2.check_stock(item4)).to eq(45)
    end

    it '#sell across vendors' do
      expect(market.sell(item1, 40)).to eq(true)
      expect(vendor1.check_stock(item1)).to eq(0)
      expect(vendor3.check_stock(item1)).to eq(60)
    end
  end
end