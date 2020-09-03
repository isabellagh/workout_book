
class UsersController < ApplicationController

  post '/users' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end 

  get '/profiles' do
    @users = User.all
    erb :index
  end
  
  get '/login' do
    @users = User.all
    erb :login
  end
  
  post '/login' do
    user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:message] = "Welcome back, #{user.name}!"
        redirect "/users/#{user.id}"
      else 
        flash[:error] = "Invalid credentials, please try again!"
        redirect '/login'
      end 
    end
  
  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    erb :show
  end
      
  get '/signup' do
    erb :'/signup'
  end 
  
  get '/users/:id/editprofile' do
    @user = User.find(params[:id])
    erb :'/edit'
  end 

  patch '/users/:id' do
    @user = User.find(params[:id])
    @user.update(name: params[:name], image_url: params[:image_url],
    bio: params[:bio])
    redirect "/users/#{@user.id}"
  end 
  
  get '/logout' do
    session.clear
    redirect '/'
  end 

  delete '/users/:id' do
    @user = User.find(params[:id])
    @user.destroy
    redirect '/'
  end 

end 