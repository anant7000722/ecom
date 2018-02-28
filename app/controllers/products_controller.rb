class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :upvote]
  include ApplicationHelper
  # GET /products
  # GET /products.json
  def index

    search = params[:search]
      if params[:search].present?
        @products = Product.where("name like? OR name like? OR name like? OR name like?","%#{search.capitalize}%","%#{search.downcase}%","%#{search.upcase}%",
          "%#{search.titleize}%")
      else
        @products = Product.all
      end
    
  end 

  def show 

    @products = Product.all
    session[:product_id] = @product.id
 
    @reviews = Review.where(product_id: @product.id).order("created_at DESC").limit(2)
    @users = User.all
   
    @reviews_for_modal = Review.where(product_id: @product.id).order("created_at DESC")
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create 
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
       if @product.update(product_params)
        
        if @product.status == true && @product.notifications
          
            user = []
            user = Notification.where(product_id: @product.id)
            notification_send(user, @product.id)
        end 
          format.html { redirect_to @product, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def upvote
    @product.upvote_by current_user
    redirect_to product_path
  end

  private
    
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :image, :category_id, :status, :price)
    end
end
