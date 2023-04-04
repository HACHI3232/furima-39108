class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id])

    redirect_to root_path if @item.order || (@item.user == current_user)
  end

  def create
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(order_params)
    pay_item
    binding.pry
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
      user_id:current_user.id,
      item_id:params[:item_id],
      token:params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'card',
      card: order_params[:token]
    )
  end

end
