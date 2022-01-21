class OrdersController < ApplicationController
  before_action :authenticate_user! ,only:[:index]
  before_action :set_item
  before_action :redirect_to_root ,only:[:index]

  def index
    @address_order = AddressOrder.new
  end

  def create
    @address_order = AddressOrder.new(oreder_params)
    if @address_order.valid?
       @address_order.save
       pay_item
      redirect_to root_path
    else
      render :index
    end
  end
  
  private

  def oreder_params
    params.require(:address_order).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number,:token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    
     Payjp::Charge.create(
        amount: @item.worth,
        card: oreder_params[:token],
        currency: 'jpy' 
      )
  end


  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_to_root
    return redirect_to root_path if current_user.id == @item.user_id || @item.order!=nil
  end
end