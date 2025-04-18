class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    base_result = @q.result(distinct: true)

    case params[:sort]
    when "Newest Products"
      @products = base_result.(created_at: 3.days.ago.beginning_of_day..Time.current)
    when "Recently Updated"
      @products = base_result.where(updated_at: 3.days.ago.beginning_of_day..Time.current)
    else
      @products = base_result
    end

    @products = @products.page(params[:page]).per(15)

    @categories = Category.pluck(:category_name)
  end

  def show
    @product = Product.find(params[:id])
  end
end
