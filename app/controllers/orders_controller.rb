class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:new, :create]

  def index
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:post_num, :prefecture_id, :city, :street_number, :building_name, :phone_num ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token], price: @item.price )
  end

	def pay_item
    Payjp.api_key = "sk_test_509a3b3fd18603fe1b0214ea"
      Payjp::Charge.create(
        amount: order_params[:price],
        card: order_params[:token],
        currency: 'jpy'
      ) 
  end

end