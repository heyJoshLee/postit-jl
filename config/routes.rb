PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy]
  resources :categories, except: [:destroy, :edit]
end
