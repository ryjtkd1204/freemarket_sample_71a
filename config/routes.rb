Rails.application.routes.draw do

  get 'card/show'

  devise_for :users, controllers:{
    registrations: "users/registrations"
  }

  root "items#index"

  resources :users, only: [:index , :show , :edit]
  resources :orders, only: [:show]

  resources :items, only: [:new,:show , :create , :edit ,:update , :destroy] do
      
   
    resources :card, only: [:index] do
      collection do
        post 'pay', to: 'card#pay'
        get 'done', to: 'card#done'
      end
    end
    
    resources :comments,only: [:create]
    member do
      get 'kakuninn'
    end
    collection do
      get 'search' 
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
   
    

  end
  
  
    resources :card, only: [:new,:create] do
      collection do
        post 'delete', to: 'card#delete'
      end
     end

end
