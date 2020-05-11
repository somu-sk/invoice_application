Rails.application.routes.draw do

  root to: 'invoices#dashboard', as: :dashboard

  resources :invoices do
    collection do
      get :dashboard
    end
  end

  resources :collections do
    member do
      put :'add_collection', as: :add_collection
    end
  end
end
