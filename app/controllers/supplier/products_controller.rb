class Supplier::ProductsController<ApplicationController
  before_action :authenticate_user!
  before_action :authorize_supplier
  before_action :get_product, only: [:show, :update, :destroy, :edit]

  def index
      @products = current_user.products
  end

  def show    
  end

  def new
    @category = Category.find(params[:cat_id])
    @product = Product.new
  end

  def create
    @category=Category.find(params[:product][:category_id])
    @product = @category.products.new(product_params)
    @product.user_id = current_user.id
    if @product.save
       redirect_to supplier_products_path(@product)
    else
       render :new
    end
  end
  
  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to supplier_product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to supplier_products_path
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :price, :picture, :user_id)
  end

  def authorize_supplier
      redirect_to root_path unless current_user.has_role?(:supplier)
  end

end