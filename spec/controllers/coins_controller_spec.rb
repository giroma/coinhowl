require "rails_helper"
require "spec_helper"

RSpec.describe CoinsController, :type => :controller do

  render_views
   describe "GET index" do
    it "check the h5 on index" do
      get :index
      expect(response.body).to match /<h5>.*BITCOIN/im
    end
  end

    describe "GET show" do
      it "Check the chart does have data on it" do
      get :show, params: { id: 'BCH' }
      expect(response.body).to match /<div id="chartdiv" data-chartarray=.*time.*/im
    end
  end

  describe "Check Top 5 coins method" do
    it "checks length of the variable equals to 5" do
      get :index
      expect(assigns(:top_5_coins).length).to equal(5)
    end
  end
  describe "Check Coin Summary Cached variable from Bittrex API" do
    it "checks type of the variable's first element to be a string" do
      get :index
      # expect(assigns(:coin_summary[0]).to be_kind_of(String)
      expect(assigns(:coin_summary).to include("BCH")
    end
  end


end
