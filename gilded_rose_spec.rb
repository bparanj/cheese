require "minitest/autorun"
require_relative "gilded_rose"

describe GildedRose do
  describe "When +5 Dexterity Vest has not expired" do
    it "quality reduces by one in one day" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 19
    end

    it "quality reduces by one in one day for expiry in 5 days" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=5, quality=20)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 19
    end
  end

  describe "When +5 Dexterity Vest has expired" do
    it "quality degrades twice as fast" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=-1, quality=20)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 18
    end

    it "quality degrades twice as fast when expiry in 0 days" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=0, quality=20)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 18
    end

    it "quality is not negative" do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=-1, quality=0)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 0
    end
  end

  describe "When Aged Brie has not expired" do
    it "quality increases by one in one day when expires is in 10 days" do
      items = [Item.new(name="Aged Brie", sell_in=10, quality=0)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 1
    end

    it "quality increases by one in one day when expires is in 5 days" do
      items = [Item.new(name="Aged Brie", sell_in=5, quality=0)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 1
    end

    it "quality increases by one in one day" do
      items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 1
    end
  end

  describe "When Aged Brie has expired" do
    it "quality increases by two in one day if quality is 0" do
      items = [Item.new(name="Aged Brie", sell_in=-1, quality=0)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 2
    end

    it "quality increases by two in one day if quality is 2" do
      items = [Item.new(name="Aged Brie", sell_in=-1, quality=2)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 4
    end

    it "quality does not exceed 50" do
      items = [Item.new(name="Aged Brie", sell_in=-1, quality=50)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 50
    end
  end

  describe "When Elixir of the Mongoose has not expired" do
    it "quality decreases by one in one day for expires in 10 days" do
      items = [Item.new(name="Elixir of the Mongoose", sell_in=10, quality=7)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 6
    end

    it "quality decreases by one in one day for expires in 5 days" do
      items = [Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 6
    end

    it "quality is not negative" do
      items = [Item.new(name="Elixir of the Mongoose", sell_in=5, quality=0)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 0
    end
  end

  describe "When Elixir of the Mongoose has expired" do
    it "quality decreases twice as fast" do
      items = [Item.new(name="Elixir of the Mongoose", sell_in=-1, quality=7)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 5
    end

    it "quality decreases twice as fast when sellin is 0" do
      items = [Item.new(name="Elixir of the Mongoose", sell_in=0, quality=7)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 5
    end
  end

  describe "When the item is Sulfuras, Hand of Ragnaros" do 
    it "does not alter quality when sell in is 0" do 
       items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
       gr = GildedRose.new(items)
 
       result = gr.update_quality
 
       _(result[0].quality).must_equal 80
    end
 
    it "does not alter quality when it has expired" do 
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 80
    end

    it "does not alter quality when it expires in 0 days" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      gr = GildedRose.new(items)
 
      result = gr.update_quality
 
      _(result[0].quality).must_equal 80
    end

    it "does not alter quality when it expires" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 80)]
      gr = GildedRose.new(items)
 
      result = gr.update_quality
 
      _(result[0].quality).must_equal 80
    end
  end

  describe "When Backstage passes to a TAFKAL80ETC concert has not expired" do
    it "quality is increased by one in one day for expires in 10 days" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 50
    end

    it "quality is increased by one in one day" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=4, quality=49)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 50
    end

    it "quality does not exceed 50" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=4, quality=50)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 50
    end
  end

  describe "When Backstage passes to a TAFKAL80ETC concert has expired" do
    it "quality drops to zero" do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=-1, quality=49)]
      gr = GildedRose.new(items)

      result = gr.update_quality

      _(result[0].quality).must_equal 0
    end
  end
end