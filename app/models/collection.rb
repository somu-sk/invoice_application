class Collection < ApplicationRecord
  belongs_to :invoice, primary_key: :reference_id, foreign_key: :reference_id, optional: true

  def self.load_collections
    json_collections = JSON.parse(File.read('/Users/somu/workspace/invoice_application/db/data/collections.json'))
    json_collections.each do |json_collection|
      collection = Collection.new
      collection['collected_amount'] = json_collection['amount'].abs
      collection['reference_id'] = json_collection['reference']
      collection['collection_date'] = json_collection['collection_date']
      collection.save!
    end
  end
end
