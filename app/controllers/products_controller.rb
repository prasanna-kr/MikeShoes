class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  # respond_to :js

  # GET /products or /products.json
  def index
    @user = User.find_by(id: session[:user_id])
    p "user>>>>>>>>#{@user.inspect}"
    # @user_wishlists = @user.wishlist

    @products = Product.paginate(:page=>params[:page],:per_page=>6)
    # byebug
    @current_cart = current_cart

    @wishlist = Wishlist.find_by_id(params[:wishlist_id])
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    p "product>>>>>>>#{@product.inspect}"
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    keyword="%" + params[:search].to_s + "%"
    @products = Product.find_by_sql ["Select * from products WHERE name like ? or description like ? or category like ?",keyword,keyword,keyword]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @cart = current_cart
      p "cart>>>>>>>>>>#{@cart.inspect}"
      @product = Product.friendly.find(params[:id])
      authorize @product
    end

    # Only allow a list of trusted parameters through.
    def product_params
      # user_id = current_user.id
      params.require(:product).permit(:name, :description, :category, :price,:stock, :product_image,:user_id)
      # authorize :product
    end
end
