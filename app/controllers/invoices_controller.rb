class InvoicesController < ApplicationController
  def create
    product_ids = invoice_params.delete(:product_ids)
    quantities = params[:invoice][:quantities]

    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      product_ids.each_with_index do |product_id, index|
        quantity = quantities[index]

        invoice_product = @invoice.invoice_products.find_or_initialize_by(product_id: product_id)
        invoice_product.quantity = quantity
        invoice_product.save
      end

      render json: { id: @invoice.id }, status: :created
    else
      render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def show
    @invoice = Invoice.find(params[:id])
    @province = Province.all
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      {
        product_ids: []
      },
      :gst, :pst, :hst, :subtotal, :total,
      :street, :city, :postal_code, :country, :province_id
    )  end
end
