class CoinsController < ApplicationController
  def index
    @response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/?convert=CAD&limit=50')
    @result = JSON.parse(@response.body)

    call_cryptocompare_api
  end

  def show
    @coin_symbol = params[:id]
    @follow = Following.where(user_id: current_user, coin_name: @coin_symbol)
    @is_following = @follow.length > 0 ? true : false


    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Day' )
    data_table.new_column('number', 'open')
    data_table.new_column('number', 'close')
    data_table.new_column('number', 'high')
    data_table.new_column('number', 'low')

    # Add Rows and Values
    data_table.add_rows([
      ['Mon', 20, 28, 38, 45],
      ['Tue', 31, 38, 55, 66],
      ['Wed', 50, 55, 77, 80],
      ['Thu', 77, 77, 66, 50],
      ['Fri', 68, 66, 22, 15]
    ])
    option = { height: 400, title: "#{@coin_symbol}" }
    @chart = GoogleVisualr::Interactive::CandlestickChart.new(data_table, option)
  end
end
