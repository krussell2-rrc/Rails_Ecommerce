require 'httparty'
require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

access_key = ENV["UNSPLASH_API_KEY"]

[ "laptops", "mobile-accessories", "smartphones", "tablets" ].each do |category_name|
  category = Category.find_or_create_by!(category_name: category_name)

  encoded_term = URI.encode_www_form_component(category_name)
  products_url = "https://dummyjson.com/products/category/#{encoded_term}"

  response = HTTParty.get(products_url)

  data = JSON.parse(response.body)

  if data["products"]
    data["products"].each do |product|
      Product.find_or_create_by!(
        product_name: product["title"],
        product_price: product["price"],
        product_description: product["description"],
        product_img: product["images"][0],
        category_id: category.id
      )
    end
  end

  if category_name == "tablets"
    encoded_term = URI.encode_www_form_component("ipad")
    unsplash_url = "https://api.unsplash.com/search/photos?query=#{encoded_term}&per_page=30&client_id=#{access_key}"
  else
    unsplash_url = "https://api.unsplash.com/search/photos?query=#{encoded_term}&per_page=30&client_id=#{access_key}"
  end

  unsplash_response = HTTParty.get(unsplash_url)
  parsed = JSON.parse(unsplash_response.body)
  results = parsed["results"]

  if results && results.is_a?(Array) && results.any?
    50.times do
      image_data = results.sample
      unsplash_image = image_data["urls"]["regular"]
      Product.find_or_create_by!(
        product_name: "#{Faker::Device.manufacturer} #{Faker::Device.model_name}",
        product_description: Faker::Lorem.paragraph(sentence_count: 3),
        product_price: Faker::Commerce.price(range: 300.0..2000.0),
        category_id: category.id,
        product_img: unsplash_image
      )
    end
  end
end
