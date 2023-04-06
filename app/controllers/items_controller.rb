class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update,:destroy]
  before_action :redirect_to_root, only: [:edit, :destroy]

  def index
    @items = Item.all.order(created_at: :DESC)
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

  def show
  end

  def edit
    return unless @item.order.present?

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :price, :name, :description, :category_id, :condition_id,
                                 :shipping_payer_id, :prefecture_id, :shipping_day_id).merge(user_id: current_user.id)
  end

  def set_item
    binding.pry

    @item = Item.find(params[:id])
  end

  def redirect_to_root
    return unless @item.user_id != current_user.id

    redirect_to root_path
  end
end
