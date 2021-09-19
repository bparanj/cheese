require_relative 'base_item'

class Conjured < BaseItem
  def process
    update do |item|
      decrease_quality_by(2)
      decrease_quality_by(2) if item.expired?
    end
  end
end