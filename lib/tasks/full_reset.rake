# frozen_string_literal: true

namespace :db do
  desc 'Fully reset the database and load fresh data from scratch'
  task full_reset: :environment do
    # Migration Tasks
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['loader:init'].invoke
  end
end
