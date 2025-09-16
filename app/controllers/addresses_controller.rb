class AddressesController < ApplicationController
  def create
    @address = Address.new(address_params)
  end
end

private

def address_params
  params.require(:address).permit(:street, :city, :postal_code, :country, :province_id)
end
