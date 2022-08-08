class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, qty)
    @inventory[item] += qty
  end

  def potential_revenue
    @inventory.sum do |item, qty|
      price = item.price.scan(/[.0-9]/).join.to_f
      price * qty
    end
  end
end
