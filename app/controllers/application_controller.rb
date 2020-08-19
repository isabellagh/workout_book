require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #turns sessions on
    set :session_secret, ENV['SESSION_SECRET'] #its an encryption key that will be used  to create a session_id
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else 
      erb :welcome
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end 

    def current_user
      User.find_by(id: session[:user_id])
    end 

    get "/signup" do
      erb :signup
    end

    get "/logout" do
      erb :logout
    end 

    # create an authorization helper for edit/delete
    def authorized_to_edit?(post)
      post.user == current_user
    end 

    
  end 

end