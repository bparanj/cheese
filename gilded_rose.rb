class BaseItem
  attr_reader :item
  UPPER_LIMIT = 50
  LOWER_LIMIT = 0

  def initialize(item)
    @item = item
  end

  def updater
    update do |item|
      item.decrease_quality
      item.decrease_quality if item.expired?
    end
  end

  protected

  def expired?
    item.sell_in < LOWER_LIMIT
  end

  def decrease_quality
    item.quality -= 1
  end
  
  def decrease_quality_by(factor)
    item.quality -= factor
  end

  def increase_quality
    item.quality += 1
  end

  def reset_quality
    item.quality = LOWER_LIMIT
  end

  private 

  def decrease_sellin
    item.sell_in -= 1
  end

  def limit_quality
    reset_quality if item.quality < LOWER_LIMIT

    item.quality = UPPER_LIMIT if item.quality > UPPER_LIMIT
  end

  def update
    decrease_sellin

    yield self if block_given?

    limit_quality
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
  VALID_RANGE = (11..6)

  def updater 
    update do |item|
      if item.expired?
        item.reset_quality
      else
        item.increase_quality
        if VALID_RANGE.cover?(item.item.sell_in)
          item.increase_quality
        end
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
