class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if @name != "Sulfuras, Hand of Ragnaros"
      if @days_remaining > 0
        change_quality_before_sell_by
      else 
        change_quality_after_sell_by
      end
      @days_remaining = @days_remaining - 1
      return_correct_range!
    end
  end

  private 

  def change_quality_before_sell_by
    if quality_decreases_over_time?
      @quality = @quality - 1
      if conjured?
        @quality = @quality - 1
      end
    else
      increase_quality
    end
  end
  
  def change_quality_after_sell_by
    if quality_decreases_over_time?
      @quality = @quality - 2
      if conjured?
      @quality = @quality - 2
      end
    elsif backstage_pass?
      @quality = 0 
    else
      @quality = @quality + 2 
    end
  end

  def return_correct_range!
    @quality = 0 if @quality < 0
    @quality = 50 if @quality > 50
  end

  def quality_decreases_over_time?
    @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured?
    !(@name.downcase =~ /^conj/).nil?
  end

  def increase_quality
    @quality = @quality + 1
    if backstage_pass?
      increase_quality_for_backstage_pass
    end
  end

  def backstage_pass?
    @name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def increase_quality_for_backstage_pass
    if @days_remaining < 11
      @quality = @quality + 1
    end
    if @days_remaining < 6
      @quality = @quality + 1
    end
  end
end
