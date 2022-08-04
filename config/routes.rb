Rails.application.routes.draw do
  namespace :api do
    resources :tasks, only: [:index,:create,:update,:destroy]
    put '/toggleAllDone'=> 'tasks#toggle_all_done'
    delete '/destroyChecked' => 'tasks#destroy_checked'
  end
end
