class AdminController < ApplicationController
  def index
    @brands = Brand.all
    @headquarters = Headquarter.all
    @colors = Color.all
    @sizes = Size.all
    @cloth_types = ClothType.all
    @variables = Variable.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
