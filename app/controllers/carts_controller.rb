class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]

  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)
    p "cart controller>>>>>>>>>>>#{@cart.inspect}"
    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def checkout
    if request.post?
      @cart = Cart.find(params[:cart_id])
      amount = @cart.total_price
      p "post method"
      ActiveMerchant::Billing::Base.mode = :test
      # Create a new credit card object
      credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => params[:card_number],
        :month      => params[:month],
        :year       => params[:year],
        :first_name => params[:first_name],
        :last_name  => params[:last_name],
        :verification_value  => params[:verification_value]
      )
      if credit_card.valid?
        # Create a gateway object to the TrustCommerce service
        gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
          :login    => 'TestMerchant',
          :password => 'password'
        )
  
  
  
        response = gateway.authorize(amount.to_i, credit_card)
        puts "=========="
        puts response.inspect
        if response.success?
          # Capture the money
          #Triger the mailer
          session[:cart_id]=nil
          # session[:cart_amount]=nil
          gateway.capture(amount.to_i, response.authorization)
          redirect_to :action=>:purchase_complete
        end
      else
        flash[:notice] = "Invalid credit card. Give proper inputs"
        render :action=>:checkout
      end

    else
      @cart = Cart.find(params[:cart_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
