class InvoicesController < ApplicationController
  def create
    product_ids = invoice_params.delete(:product_ids)

    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      product_ids.each do |product_id|
        @invoice.invoice_products.create(product_id: product_id)
      end

      render json: { id: @invoice.id }, status: :created
    else
        puts "INVOICE SAVE FAILED: #{@invoice.errors.full_messages}"
      render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def show
    @invoice = Invoice.find(params[:id])
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
