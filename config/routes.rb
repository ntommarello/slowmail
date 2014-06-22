Slowmail::Application.routes.draw do


  get "users/settings"

  get "users/index"

  get "letters/create"

   match 'auth/:provider/callback', to: 'sessions#create'
   match 'auth/failure', to: redirect('/')
   match 'logout', to: 'sessions#destroy', as: 'logout'

   match 'draft', to: 'letters#draft', as: 'draft'
   match 'random', to: 'web#random', as: 'random'

   match 'save_draft', to: 'users#save_draft', as: 'save_draft'

   root :to => 'web#home'

   resource :letters

end
