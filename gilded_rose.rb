class BaseItem
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
    decrease_sellin

    yield self if block_given?

    limit_quality
  end

  def updater
    update do |item|
      item.decrease_quality
      item.decrease_quality if item.expired?
    end
  end

  protected

  def expired?
    item.sell_in < 0
  end

  def decrease_quality
    item.quality -= 1
  end
  
  def decrease_quality_by(factor)
    item.quality -= factor
  end

  def increase_quality
    item.quality +=1
  end

  def reset_quality
    item.quality = 0
  end

  private 

  def decrease_sellin
    item.sell_in -= 1
  end

  def limit_quality
    reset_quality if item.quality < 0

    item.quality = 50 if item.quality > 50
  end
end

class AgedBrie < BaseItem
  def updater
    update do |item|
      item.increase_quality
  
      item.increase_quality if item.expired?
    end
  end
end

class Backstage < BaseItem
  def updater 
    update do |item|
      if item.expired?
        item.reset_quality
      else
        item.increase_quality
        item.increase_quality if item.item.sell_in < 11
        item.increase_quality if item.item.sell_in < 6
      end
    end
  end
end

class ConjuredItem < BaseItem
  def updater
    update do |item|
      decrease_quality_by(2)
      decrease_quality_by(2) if item.expired?
    end
  end
end

class Sulfuras < BaseItem
  def updater 
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        aged_brie = AgedBrie.new(item)
        aged_brie.updater
      when "Backstage passes to a TAFKAL80ETC concert"
        concert = Backstage.new(item)
        concert.updater
      when "Sulfuras, Hand of Ragnaros"
        sulfuras = Sulfuras.new(item)
        sulfuras.updater
      when "Conjured Mana Cake"
        conjure = ConjuredItem.new(item)
        conjure.updater
      else
        base_item = BaseItem.new(item)
        base_item.updater
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
