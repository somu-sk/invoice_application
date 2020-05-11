class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :brand_manager
      t.string :narration
      t.string :invoice_date
      t.integer :total_amount
      t.string :customer_name
      t.string :reference_id

      t.timestamps
    end
  end
end
