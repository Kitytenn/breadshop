class OrdersController < ApplicationController
  def new
    render json: { hello: true }
  end
end
