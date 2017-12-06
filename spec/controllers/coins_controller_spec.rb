require "rails_helper"
require "spec_helper"
attr_accessor :response_only_btc

RSpec.describe CoinsController, :type => :controller do
  render_views
   let(:response_only_btc) { @response_only_btc }
  describe "GET index" do
    it "check the h5 on index" do
      get :index
      expect(response.body).to match /<h5>.*BITCOIN/im
    end


  end
end
