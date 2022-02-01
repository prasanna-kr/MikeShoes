class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @cart = @current_cart
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def checkout
    if request.post?
      @cart = Cart.find(params[:order_id])
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
      p "credit_card>>>>>>>>>>>>#{credit_card}"
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
          # @cart = current_cart
          @order = Order.new
          @order.update(user_id: current_user.id,cart_id: session[:cart_id],status:1)
          @order.save!
          # product = Product.find(params[:product_id])
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
      @cart = Cart.find(params[:order_id])
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:cart_id, :user_id, :status)
    end
end
