Rails.application.routes.draw do
  get '/departments', to: 'departments#index'
  get '/employees/:id', to: 'employees#show'
  patch '/employees/:id', to: 'employees#update'
end

