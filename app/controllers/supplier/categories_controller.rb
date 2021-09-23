class Supplier::CategoriesController<ApplicationController
	before_action :authenticate_user!
	before_action :authorize_supplier

	def index
		@categories = Category.all
	end

	def show
		@category = Category.find(params[:id])
		@subcategories = @category.subcategories.all
	end

    private
	def category_params
        params.require(:category).permit(:name, :parent_id)
    end

    def authorize_supplier
    	redirect_to root_path unless current_user.has_role?(:supplier)
    end

end