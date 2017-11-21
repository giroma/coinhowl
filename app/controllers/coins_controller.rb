class CoinsController < ApplicationController
  def index
  end

  def show
    @coin = params[:id]
  end
end
