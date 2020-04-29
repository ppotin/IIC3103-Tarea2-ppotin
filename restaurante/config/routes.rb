Rails.application.routes.draw do
  resources :ingredientes, path: 'ingrediente'
  resources :hamburguesas, path: 'hamburguesa'
  delete 'hamburguesa/:hamburguesa_id/ingrediente/:ingrediente_id' => 'hamburguesas#destroy_ingrediente'
  put 'hamburguesa/:hamburguesa_id/ingrediente/:ingrediente_id' => 'hamburguesas#put_ingrediente'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
