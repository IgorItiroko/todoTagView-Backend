Rails.application.routes.draw do
  namespace :api do
    resources :tasks, only: [:index,:create,:update,:destroy]
    put '/checkAll'=> 'tasks#check_all'
    put '/uncheckAll' => 'tasks#uncheck_all'
    delete '/destroyChecked' => 'tasks#destroy_checked'
  end
end
