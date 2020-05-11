class CollectionsController < ApplicationController
  def new
    @collection = Collection.new()
  end

  def create
    collection = params[:collection]
    if collection[:reference_id].present? && collection[:collected_amount].present?
      Collection.create!(reference_id: collection[:reference_id], collected_amount: collection[:collected_amount], collection_date: collection[:collection_date])
    end

    invoice_id = Invoice.find_by(reference_id: collection['reference_id'])&.id

    redirect_to controller: 'invoices' , action: "show", id: invoice_id
  end
end
