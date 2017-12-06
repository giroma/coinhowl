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

end
