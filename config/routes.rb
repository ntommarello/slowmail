Slowmail::Application.routes.draw do




   match 'auth/:provider/callback', to: 'sessions#create'
   match 'auth/failure', to: redirect('/')
   match 'logout', to: 'sessions#destroy', as: 'logout'

   match 'draft', to: 'letters#draft', as: 'draft'
   match 'random', to: 'web#random', as: 'random'

   match 'save_draft', to: 'letters#save_draft', as: 'save_draft'
   match 'mail_letter', to: 'letters#mail_letter', as: 'mail_letter'

   match 'my_drafts', to: 'users#my_drafts', as: 'my_drafts'

   match 'about', to: 'web#about', as: 'about'
   match 'terms', to: 'web#terms', as: 'terms'
   match 'privacy', to: 'web#privacy', as: 'privacy'

   match '/with/:username', to: 'letters#index', as: 'letters_index', :username => /[A-Za-z0-9\.]+?/, :format => /json|csv|xml|yaml/, :method=>:get
   match '/with/:username/reply', to: 'letters#draft', as: 'letters_reply', :username => /[A-Za-z0-9\.]+?/, :format => /json|csv|xml|yaml/, :method=>:get

   match '/letter/:id/deliver_now', to: 'letters#deliver_now'

   root :to => 'web#home'

   resources :letters

end