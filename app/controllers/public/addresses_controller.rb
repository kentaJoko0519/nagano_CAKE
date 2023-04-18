class Public::AddressesController < ApplicationController
  def index
    @address=Address.new
    @addresses=Address.all
    @customer=current_customer
  end
  
  def create
    @address=Address.new(address_params)
    @address.customer_id=current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postal_code, :name, :address, :customer_id)
  end
  
end
