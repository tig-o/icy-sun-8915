Rails.application.routes.draw do
  get '/departments', to: 'departments#index'
  get '/employees/:id', to: 'employees#show'
end

