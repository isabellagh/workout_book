
class UsersController < ApplicationController

  get '/login' do
    @users = User.all
     erb :login
  end
  
  post '/login' do
    @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id #assign to
        flash[:message] = "Welcome back, #{@user.name}!"
          redirect "/users/#{@user.id}"
      else 
        flash[:error] = "Invalid credentials, please try again!"
          redirect '/login'
      end 
  end

  post '/users' do
    if params[:name] != "" && params[:email] != "" && params[:password] != "" && params[:image_url] != "" && params[:bio] != ""
      @user = User.create(params)
      session[:user_id] = @user.id #logs the user in
        redirect "/users/#{@user.id}"
    else
      flash[:error] = "Please fill out all fields"
        redirect '/signup'
    end 
  end 

  get "/users/:id" do
    find_user
      erb :show
  end

  get '/signup' do
    erb :signup
  end 

  get '/profiles' do
    @users = User.all
      erb :index
  end 

  get '/profiles/:id' do
    find_user
      erb :profile
  end 

  get '/users/:id/editprofile' do
    find_user
    if current_user
      erb :edit
    else 
      flash[:error] = "Not authorized to edit this profile!"
      redirect "/users"
    end 
    
  end

  patch '/users/:id' do
    find_user
    @user.update(name: params[:name], image_url: params[:image_url],
    bio: params[:bio])
    #binding.pry
      redirect "/users/#{@user.id}"
  end 
  
  get '/logout' do
    session.clear
      redirect '/'
  end 

  #delete '/users/:id' do
  #  find_user
  #  @user.destroy
  #    redirect '/'
  #end 

  private

  def find_user
    @user = User.find(params[:id])
  end 

end 