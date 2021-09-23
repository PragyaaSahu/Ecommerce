 class Customer::ReviewsController < ApplicationController

 before_action :findproduct, except: [:create]
 before_action :find_review, only: [:edit, :update, :destroy]

 def new
   @rating = Rating.new
   @review = Review.new
   @reviews = Review.all
 end

 def create
   @review = Review.new(review_params)
   @product = Product.find(params[:review][:product_id])
   
   if @review.save
     redirect_to request.referrer
   else
     render 'new'
   end
   @rating = Rating.new(product_id: params[:product_id], user_id: current_user.id, rating: params[:rating])
   if @rating.save
      redirect_to request.referrer
   else
      render 'new'
   end
 end

 def edit
 end

 def update
   if @review.update(review_params)
     redirect_to user_path(@product)
   else
     render 'edit'
   end 
 end 

 def destroy
   @review.destroy
   redirect_to user_path(@product)
 end

 private
 def review_params
   params.require(:review).permit(:rating, :comments, :product_id, :user_name)
 end

 def find_product
   @product = Product.find(params[:id])
 end
 
end