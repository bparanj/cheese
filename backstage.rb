require_relative 'base_item'

class Backstage < BaseItem
  VALID_RANGE = (11..6)

  def process 
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