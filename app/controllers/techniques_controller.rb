class TechniquesController < ApplicationController
  def show
    @technique = Technique.find(params[:id])
  end
end
