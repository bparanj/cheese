require_relative 'base_item'

class AgedBrie < BaseItem
  def process
    update do |item|
      item.increase_quality
  
      item.increase_quality if item.expired?
    end
  end
end