Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}



# 顧客用
  scope module: :public do
  # homes
    root to: "homes#top"
    get"/about"=>"homes#about",as: 'about'
  # items
    get"/items"=>"items#index",as: 'items'
    get"/items/:id"=>"items#show",as: 'item'
  # customers
    get"/customers/my_page"=>"customers#show",as: 'my_page'
    get"/customers/information/edit"=>"customers#edit",as: 'edit_information_customer'
    patch"/customers/information"=>"customers#update"
    get "/customers/unsubscribe"=>"customers#unsubscribe",as: 'unsubscribe'
    patch "/customers/withdraw"=>"customers#withdraw"
  # cart_items
    delete"/cart_items/destroy_all"=>"cart_items#destroy_all",as: 'destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
  # orders
    get"/orders/new"=>"orders#new",as: 'new_order'
    post "/orders/confirm"=>"orsers#confirm", as: 'confirm'
    get "/orders/complete"=>"orsers#complete", as: 'complete'
    post"/orders"=>"orders#create"
    get"/orders"=>"orders#index"
    get"/orders/:id"=>"orders#show",as: 'order'
  #addresses
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  # 管理者用
  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :show, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
