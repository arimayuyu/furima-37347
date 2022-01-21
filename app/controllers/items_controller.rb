class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  #before_action :set_item, only: [:edit, :update, :show, :destroy]
  #before_action :redirect_to_show, only:[:edit, :update, :destroy]  

  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  #def destroy
    #@item.destroy
    #redirect_to root_path
  #end

  #def edit
    #@item = Item.find(params[:id])
  #end

  #def update
    #if @item.update(item_params)
      #redirect_to item_path(@item)
    #else
      #render :edit
    #end
  #end

  def show
    @item = Item.find(params[:id])
  end

 
  private

  def item_params
    params.require(:item).permit(
      :name, :image, :description, :detail_id, :regarding_delivery_id, :selling_price_id, 
      :category_id, :prefecture_id, :worth ).merge(user_id: current_user.id)
  end

  #def redirect_to_show
    #return redirect_to root_path if current_user.id != @item.user.id || @item.order!=nil
  #end
      
  #def set_item
        #@item = Item.find(params[:id])
  #end

  
end