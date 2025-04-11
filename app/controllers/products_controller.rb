class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    base_result = @q.result(distinct: true)

    case params[:sort]
    when "Newest Products"
      @products = base_result.order(created_at: :desc)
    when "Recently Updated"
      @products = base_result.order(updated_at: :desc)
    else
      @products = base_result
    end

    @products = @products.page(params[:page]).per(15)
  end

  def show
    @product = Product.find(params[:id])
  end
end
