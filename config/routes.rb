Rails.application.routes.draw do

  root to: 'invoices#index', as: :root

  resources :invoices do
    collection do
      get :'collected_bills', as: :collected
      get :'pending_bills', as: :pending
      get :'dashboard', as: :dashboard
    end
  end

  resources :collections do
    member do
      put :'add_collection', as: :add_collection
    end
  end
end
