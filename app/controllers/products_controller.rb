class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page]).per(15)
  end

  def show
    @product = Product.find(params[:id])
  end
end
