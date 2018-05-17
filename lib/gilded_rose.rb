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
        change_quality_after_sell_date
      end
      @days_remaining = @days_remaining - 1
    end
  end

  private 

  def change_quality_before_sell_by
    if quality_decreases_over_time?
      if @quality > 0
        @quality = @quality - 1
        if conjured?
          if @quality > 0
            @quality = @quality-1
          end
        end
      end
    else
      increase_quality
    end
  end
  
  def change_quality_after_sell_date
    if quality_decreases_over_time?
      if @quality >= 2
        @quality = @quality - 2
        if conjured?
          if @quality >= 2
            @quality = @quality - 2
          end
        end
      end
    elsif backstage_pass?
        @quality = @quality - @quality 
    else
      if @quality < 50
        @quality = @quality + 1 
      end 
      if @quality < 50
        @quality = @quality + 1
      end
    end
  end

  def backstage_pass?
    @name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured?
    !(@name.downcase =~ /^conj/).nil?
  end


  def increase_quality
    if @quality < 50
      @quality = @quality + 1
      if backstage_pass?
        if @days_remaining < 11
          if @quality < 50
            @quality = @quality + 1
          end
        end
        if @days_remaining < 6
          if @quality < 50
            @quality = @quality + 1
          end
        end
      end
    end
  end


  

  def quality_decreases_over_time?
    @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
  end
end
