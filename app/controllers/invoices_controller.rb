class InvoicesController < ApplicationController
  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      render json: { id: @invoice.id }, status: :created
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:product_id, :gst, :pst, :hst, :subtotal, :total, :street, :city, :postal_code, :country, :province_id)
  end
end
