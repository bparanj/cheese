class BaseItem
  attr_reader :item

  UPPER_LIMIT = 50
  LOWER_LIMIT = 0

  def initialize(item)
    @item = item
  end

  def process
    update do |item|
      item.decrease_quality_by(1)
      item.decrease_quality_by(1) if item.expired?
    end
  end

  protected

  def expired?
    item.sell_in < LOWER_LIMIT
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

    reset_upper_quality if item.quality > UPPER_LIMIT
  end

  def update
    decrease_sellin

    yield self

    limit_quality
  end

  def reset_upper_quality
    item.quality = UPPER_LIMIT
  end
end