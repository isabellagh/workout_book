require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, ENV['SESSION_SECRET'] 
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else 
      erb :welcome
    end
  end

  get "/signup" do
    erb :signup
  end

  get "/logout" do
    erb :logout
  end 


  helpers do

    def logged_in?
      !!current_user
    end 

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) #memoization. if the current_user is populated is not getting the databse again
    end 

    def authorized_to_edit?(post)
      post.user == current_user
    end    
  end 
end