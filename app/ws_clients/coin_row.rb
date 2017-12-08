class CoinRow
  attr_accessor :name, :symbol, :volume, :pct_change, :last_price, :high_24hr, :low_24hr, :prev_day, :added, :image_url
    @name
    @symbol
    @volume
    @pct_change
    @last_price
    @high_24hr
    @low_24hr
    @prev_day
    @added
    @image_url

    def percentage_change(last_price, prev_day)
      pct_change = number_with_precision((( last_price - prev_day)/prev_day )*100, precision: 2)
      return pct_change
    end
end
