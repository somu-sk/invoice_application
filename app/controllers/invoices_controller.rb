class InvoicesController < ApplicationController
  def dashboard
    @show_table = params['type'].present? ? Invoice.filtered_bills(params['type']): Invoice.includes(:collections).order(invoice_date: :desc)

    # sending values as array of hashes
    # @show_table = params['type'].present? ? Invoice.filtered_bills(params['type']) : Invoice.dashboard_data
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new()
  end

  def create
    invoice = params[:invoice]
    if invoice[:reference_id].present? && invoice[:total_amount].present? && invoice[:brand_manager].present?
      Invoice.create!(reference_id: invoice[:reference_id], total_amount: invoice[:total_amount], invoice_date: invoice[:invoice_date], narration: invoice[:narration], customer_name: invoice[:customer_names], brand_manager: invoice[:brand_manager])
    end
    redirect_to '/'
  end
end
