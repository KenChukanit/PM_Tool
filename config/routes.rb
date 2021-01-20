Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  get("/home", to: "home#index")
  get("/about", to: "home#about")

  resources :projects do
    resources :tasks, only: [:create, :destroy, :update]
    resources :discussions, only: [:new, :create, :destroy, :update, :edit] do
      resources :comments, only: [:new, :create, :destroy, :update, :edit]
    end
  end

  resources :users, only: [:new, :create, :edit, :update, :destroy] do
    resource :passwords, only: [:edit, :update]
  end

  resource :session, only: [:new, :create, :destroy]

end

