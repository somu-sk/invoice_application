class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.dashboard_data
    @collected_bills = Invoice.collected_bills
    @pending_bills = Invoice.pending_bills
    @show_table = @invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new()
  end

  def dashboard
   render :template => 'invoices/index'
  end

  def create
    invoice = params[:invoice]
    if invoice[:reference_id].present? && invoice[:total_amount].present? && invoice[:brand_manager].present?
      Invoice.create!(reference_id: invoice[:reference_id], total_amount: invoice[:total_amount], invoice_date: invoice[:invoice_date], narration: invoice[:narration], customer_name: invoice[:customer_names], brand_manager: invoice[:brand_manager])
    end
    redirect_to '/'
  end

  def collected_bills
    # @invoices = Invoice.includes(:collections).select{ |invoice| invoice.total_amount == (invoice.collections.pluck(:collected_amount).reduce(:+).to_i)}
    @invoices = Invoice.collected_bills
  end

  def pending_bills
    @show_table = pending_table
  end


  private
    def pending_table
      @pending_table ||= Invoice.pending_bills
    end

    def collected_table
      @collected_table ||= Invoice.collected_bills
    end
end
