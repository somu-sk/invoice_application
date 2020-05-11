class Invoice < ApplicationRecord
  has_many :collections, primary_key: :reference_id, foreign_key: :reference_id

  INVOICE_FIELDS = ['brand_manager', 'narration', 'invoice_date','customer_name']

  def self.load_invoices
    json_invoices = JSON.parse(File.read('/Users/somu/workspace/invoice_application/db/data/new_invoices.json'))
    json_invoices.each do |json_invoice|
      invoice = Invoice.new
      INVOICE_FIELDS.each do |field|
        invoice[field] = json_invoice[field]
      end
      invoice['total_amount'] = json_invoice['amount']
      invoice['reference_id'] = json_invoice['reference']
      invoice.save!
    end
  end

  def pending_invoice(invoice)
    invoice.total_amount != invoice.collections.pluck(:collected_amount).reduce(:+).to_i
  end

  def self.dashboard_data
    data_array = []
    Invoice.includes(:collections).order(invoice_date: :desc).each do |invoice|
      data_hash = {}
      data_hash = invoice.attributes
      data_hash['collected_amount'] = invoice.collections.pluck(:collected_amount).reduce(:+).to_i
      data_hash['type'] = data_hash['total_amount'] != data_hash['collected_amount'] ? 'pending' : 'collected'
      data_array << data_hash
    end
    data_array
  end

  def self.filtered_bills(type)
    (type == 'pending') ? Invoice.includes(:collections).order(invoice_date: :desc).select{ |invoice| invoice.total_amount != (invoice.collections.pluck(:collected_amount).reduce(:+).to_i)} : Invoice.includes(:collections).order(invoice_date: :desc).select{ |invoice| invoice.total_amount == (invoice.collections.pluck(:collected_amount).reduce(:+).to_i)}

    # data_array = Invoice.dashboard_data
    # filtered_array = data_array.map {|invoice| invoice if invoice['type'] == type}
    # filtered_array.compact
  end

end
