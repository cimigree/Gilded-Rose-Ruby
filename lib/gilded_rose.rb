module GildedRose
  class Item
    attr_reader :days_remaining, :quality
    
    def initialize(days_remaining, quality)
      @days_remaining, @quality = days_remaining, quality
    end
  
    def tick
      @days_remaining -= 1
      @quality = 0 if @quality < 0
      @quality = 50 if @quality > 50
    end
  end

  class NormalItem < Item
    def tick
      @quality -= 1
      @quality -= 1 if @days_remaining <= 0
      super
    end
  end
  
  class Brie < Item
    def tick
      @quality += 1
      @quality += 1 if @days_remaining <= 0
      super
    end
  end

  class BackstagePass < Item
    def tick
      @quality += 1
      @quality += 1 if @days_remaining <= 10
      @quality += 1 if @days_remaining <= 5
      @quality = 0 if @days_remaining <= 0
      super
    end
  end

  class Conjured < Item
    def tick
      @quality -= 2
      @quality -= 2 if @days_remaining <= 0
      super
    end
  end

  class Sulfurus < Item
    def tick
    end
  end

  ITEM_CLASSES = {
    'Normal Item' => NormalItem,
    'Aged Brie' => Brie,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePass,
    'Conjured Mana Cake' => Conjured,
    'Sulfuras, Hand of Ragnaros' => Sulfurus
  }

  def self.new(name:, days_remaining:, quality:)
    ITEM_CLASSES[name].new(days_remaining, quality)
  end

end
