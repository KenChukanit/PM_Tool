Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  get("/home", to: "home#index")
  get("/about", to: "home#about")

  resources :projects do
    resources :favourites, shallow: :true, only: [:create, :destroy]
    get :favourited, on: :collection
    resources :tasks, only: [:create, :destroy, :update]
    resources :discussions, only: [:new, :create, :destroy, :update, :edit] do
      resources :comments, only: [:new, :create, :destroy, :update, :edit]
    end

  end

  resources :favourites, only: [:index]

  resources :users, only: [:new, :create, :edit, :update, :destroy] do
    get("change_password", to: "users#change_password")
    post('do_reset_password', to: "users#do_change_password")
    resource :passwords
  end

  resource :session, only: [:new, :create, :destroy]
  resources :admins, only: [:index]

end

