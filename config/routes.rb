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
  namespace :public do
    resources :homes, only: [:top, :about]
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get "/customers/unsubscribe"=>"customers#unsubscribe",as: 'unsubscribe'
    patch "/customers/withdraw"=>"customers#withdraw",as: 'withdraw'
    resources :cart_items, only: [:create, :index, :update, :destroy,]
    delete"/cart_items/destroy_all"=>"cart_items#destroy_all",as: 'destroy_all'
    resources :orders, only: [:new, :create, :index, :show]
    post "/orders/confirm"=>"orsers#confirm", as: 'confirm'
    get "/orders/complete"=>"orsers#complete", as: 'complete'
    resources :addresses, only: [:create, :index, :edit, :update, :destroy]
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
