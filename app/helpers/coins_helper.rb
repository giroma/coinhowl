module CoinsHelper

  def truncate_coin_name(string)
    if string.length > 15
      string[0..11]+"..."
    else
      string
    end
  end
end
