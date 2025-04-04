ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment

  # permit_params :product_img, :product_name, :product_price, :product_description, :category_id

  # or

  permit_params do
    permitted = [ :product_img, :product_name, :product_price, :product_description, :category_id, :category_name ]
    permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end
end
