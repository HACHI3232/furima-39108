class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @order_form = OrderForm.new
    if  @item.order.present? || current_user == @item.user
      redirect_to root_path
    end
  end

  def create
    @order_form = OrderForm.new(order_params)
    pay_item
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(
      :postcode,
      :prefecture_id,
      :city,
      :block,
      :building,
      :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.create(
      description: 'test',
      card: order_params[:token],
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
