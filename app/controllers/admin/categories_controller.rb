class Admin::CategoriesController<ApplicationController
  
  before_action :authenticate_user!
  before_action :get_category, except: [:index, :new, :create]
  before_action :authorize_admin


  def index
    @categories = Category.only_categories
  end

  def new
    @category = Category.new
  end

  def create
    @category=Category.new(category_params)
    if @category.save
       if @category.parent_id.present?
          redirect_to request.referrer
       else
          redirect_to admin_categories_path
       end
    else
       render :new
    end
  end

  def show
    @sub_category = Category.new
    
  end

  def destroy
    @category.destroy
    redirect_to request.referrer
  end

  def edit
  end

  def update
      if @category.update(category_params)
         redirect_to admin_categories_path
      else
        render :edit
      end
  end

  private

  def get_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def authorize_admin
      redirect_to root_path unless current_user.has_role?(:admin)
  end
end