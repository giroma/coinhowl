require "rails_helper"
require "spec_helper"

RSpec.describe ApplicationController, :type => :controller do

  describe "Read response from Bittrex API" do
    it "checks the object type to be a kind of string" do
      expect(controller.call_bittrex[0]["MarketName"]).to be_kind_of(String)
    end
  end

  describe "Read response from CoinMarketCap API" do
    it "checks response from API saved in variable" do
      expect(controller.call_coin_market_cap[0]["id"]).to be_kind_of(String)
    end
  end

  describe "Check Top 5 coins method" do
    it "checks length of the return equals to 5" do
      expect(controller.top_5_coins.length).to equal(5)
    end
  end
end
