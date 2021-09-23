class HomeController < ApplicationController
  def index
  	@q = Product.ransack(params[:q])
	@products = @q.result.page(params[:page]).per(6)
  	@categories = Category.all
  end

  def show
	  @subcategory = Category.find(params[:id])
      @products = Product.where(category_id: @subcategory.id)
  end

end
