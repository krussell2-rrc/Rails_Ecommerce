ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  actions :all
  permit_params :id, :id_value, :product_img, :product_name, :product_price, :product_description, :category_id
end
