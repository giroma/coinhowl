require "rails_helper"
require "spec_helper"

RSpec.describe ApplicationController, :type => :controller do

  describe "Read response from Bittrex API" do
    it "checks the object type to be a kind of string" do
      expect(controller.call_bittrex[0]["MarketName"]).to be_kind_of(String)
    end
  end

  describe "Read response from CoinMarketCap API" do
    it "checks the response object type to be a kind of string" do
      expect(controller.call_coin_market_cap[0]["id"]).to be_kind_of(String)
    end
  end

  describe "Read response from CryptoCompare API" do

    it "checks the response includes a popular coin called 'Bitcoin Cash'" do
      expect(controller.call_cryptocompare_api).to include("BCH")
    end

    it "checks the response object type to be at least 200 items" do
      expect(controller.call_cryptocompare_api.length).to be >= 200
    end
  end

  describe "Check Top 5 coins method" do
    it "checks length of the return equals to 5" do
      expect(controller.top_5_coins.length).to equal(5)
    end
  end
end
