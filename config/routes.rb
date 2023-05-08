Rails.application.routes.draw do
    root 'pages#home'
    get 'about', to: 'pages#about'
    resources :articles
    get 'signup', to: 'users#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'
    resources :categories
    resources :users do
        collection do
          get 'download_csv'
        end
      end
end
