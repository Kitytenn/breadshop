class ProductsController < ApplicationController
  def index
    render json: { rustic: { name: 'Rustic', quantity: 4 },
                   bagels: { name: 'Bagels', quantity: 0 } }
  end
  
  def show
    render json: { name: params[:id], quantity: 4 }
  end
end
