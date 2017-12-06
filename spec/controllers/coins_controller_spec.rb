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


end
