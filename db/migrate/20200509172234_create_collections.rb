class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :reference_id
      t.string :collection_date
      t.integer :collected_amount

      t.timestamps
    end
  end
end
