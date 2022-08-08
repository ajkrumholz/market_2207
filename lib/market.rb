class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory[item] > 0
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, qty|
        item.name
      end
    end.uniq.sort
  end

  # def all_items
  #   @vendors.flat_map do |vendor|
  #     vendor.inventory.map do |item, qty|
  #       item
  #     end
  #   end.uniq
  # end

  def total_inventory
    total = Hash.new { |hash, item| hash[item] = {qty: 0, vendors: []} }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, qty|
        total[item][:qty] += qty
        total[item][:vendors] << vendor
      end
    end
    total
  end

end
