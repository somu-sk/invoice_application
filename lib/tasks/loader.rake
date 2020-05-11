# frozen_string_literal: true

namespace :loader do
  desc 'Load invoices and collections from json files'
  task init: :environment do
    Invoice.load_invoices
    Collection.load_collections
  end
end
