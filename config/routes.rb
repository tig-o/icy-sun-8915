Rails.application.routes.draw do
  get '/departments', to: 'departments#index'
end

