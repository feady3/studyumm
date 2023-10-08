Rails.application.routes.draw do
  # main
  get '/home' => 'main#home'
  get '/search' => 'main#search_page'
  get '/search/:tab' => 'main#search_page'
  get '/search/:tab/:keyword' => 'main#search_page'
  post '/search_form' => 'main#search_form'
  get '/community' => 'main#community'
  # sessions
  get '/sessions/login' => 'user#login_form'
  post '/sessions/login' => 'user#login'
  get '/sessions/signup' => 'user#signup_form'
  post '/sessions/signup' => 'user#signup'
  # users
  get '/@:user_id' => 'user#user_page'
  get '/settings/:tab' => 'user#settings'
  post '/settings/edit_profile' => 'user#edit_profile'
  #post
  get '/share' => 'post#share_form'
  #groups
  get '/community/create/' => 'communities#create_page'
  post '/community/create/' => 'communities#create'
  get '/community/create/:group' => 'communities#create_page'
  post '/community/create/:group' => 'communities#create'
  get '/community/:uniqid' => 'communities#community_page'
  get '/community/:uniqid/:tab' => 'communities#community_page'
  post '/group_join/:user/:group' => 'communities#group_join'
  post '/group_getout/:user/:group' => 'communities#group_getout'
end
