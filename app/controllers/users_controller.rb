class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  def show
    @user = current_user
  end

  def update
    address = current_user.address
    address.update!(updated_address)

    redirect_to user_path(current_user)
  end

  private
  def updated_address
    params.require(:user).permit(
 :street, :city, :postal_code, :country, :province_id)
  end
end
