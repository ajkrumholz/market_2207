require 'date'

class Market
  attr_reader :name,
              :vendors,
              :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime('%d/%m/%Y')
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory[item].positive?
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, _qty|
        item.name
      end
    end.uniq.sort
  end

  def total_inventory
    total = Hash.new { |hash, item| hash[item] = { qty: 0, vendors: [] } }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, qty|
        total[item][:qty] += qty
        total[item][:vendors] << vendor
      end
    end
    total
  end

  def overstocked_items
    overstocks = []
    total_inventory.each do |item, details|
      overstocks << item if details[:vendors].size > 1 && details[:qty] > 50
    end
    overstocks
  end

  def sell(sale_item, qty)
    if qty > total_inventory[sale_item][:qty]
      false
    else
      process_sale(sale_item, qty)
    end
  end

  def process_sale(sale_item, qty)
    total_inventory[sale_item][:vendors].each do |vendor|
      if vendor.inventory[sale_item] > qty
        vendor.inventory[sale_item] -= qty
        return true
      elsif vendor.inventory[sale_item] < qty
        qty -= vendor.inventory[sale_item]
        vendor.inventory[sale_item] = 0
      end
    end
  end
end
