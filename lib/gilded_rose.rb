class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
    @unchangeable_item if @name == "Sulfuras, Hand of Ragnaros"
  end

  def tick
    return if @unchangeable_item
    age_item
    @quality = 0 if @quality < 0
    @quality = 50 if @quality >= 50
    @days_remaining -= 1
  end


  def age_item
    case @name
      when "Aged Brie" then age_brie
      when "Backstage passes to a TAFKAL80ETC concert" then age_backstage_passes
      when "Conjured Mana Cake" then age_conjured
      else age_normal_item
    end
  end

  def age_brie
    @days_remaining > 0 ? @quality += 1 : @quality += 2
  end

  def age_backstage_passes
    if @days_remaining <= 0
      return @quality = 0 
    else
      @quality += 1
      @quality += 1 if @days_remaining <= 10
      @quality += 1 if @days_remaining <= 5
    end
  end

  def age_conjured
    age_normal_item
    age_normal_item
  end

  def age_normal_item
    @days_remaining > 0 ? @quality -= 1 : @quality -= 2
  end
end
