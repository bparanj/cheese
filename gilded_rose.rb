require_relative 'base_item'
require_relative 'aged_brie'
require_relative 'backstage'
require_relative 'sulfuras'
require_relative 'conjured'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        aged_brie = AgedBrie.new(item)
        aged_brie.process
      when "Backstage passes to a TAFKAL80ETC concert"
        concert = Backstage.new(item)
        concert.process
      when "Sulfuras, Hand of Ragnaros"
        sulfuras = Sulfuras.new(item)
        sulfuras.process
      when "Conjured Mana Cake"
        conjure = Conjured.new(item)
        conjure.process
      else
        base_item = BaseItem.new(item)
        base_item.process
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
