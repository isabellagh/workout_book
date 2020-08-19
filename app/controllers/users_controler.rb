
class UsersController < ApplicationController

    # post sign up route that receive input data from user, create the user, and logs user in
    post '/users' do
      # will eventually need to add validations to confirm all inputs are filled out before creating user
      @user = User.create(params)
      #post sign up route to create user using params and add key/value pair to sessions hash
      session[:user_id] = @user.id
      #redirect to user profile
      redirect "/users/#{@user.id}"
    end 
  
    get '/login' do
      @users = User.all
      #binding.pry
      erb :login
    end
  
    post '/login' do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        #binding.pry
        session[:user_id] = user.id
        #binding.pry
        # add a successfull message to the flash hash
        flash[:message] = "Welcome back, #{user.name}!"
        redirect "/users/#{user.id}"
      else 
        # show an error message
        flash[:error] = "Invalid credentials, please try again!"
        redirect '/login'
      end 
    end
  
    get "/users/:id" do
      #binding.pry
      # find the user
      @user = User.find_by(id: params[:id])
        erb :show
    end
      
  
    #SIGN UP
    # get sign up route that renders sign up form
    get '/signup' do
      #render my sign up form
      erb :'/signup'
    end 
  
     # UPDATE
    # edit button that takes to the form 
    # render an edit form
    # patch method/route that will update the post
    # create a link to edit form on post show page
    # get route to render a edit form
    get '/users/:id/editprofile' do
      @user = User.find(params[:id])
        erb :'/edit'
    end 

    # 'use Rack::MethodOverride' in 'config.ru'
    # patch to send our params to and update new post (or resource)
    patch '/users/:id' do
      @user = User.find(params[:id])
      @user.update(name: params[:name], image_url: params[:image_url],
      bio: params[:bio])
      redirect "/users/#{@user.id}"
    end 
  
    # LOG OUT
    # get logout that clears the session hash
    get '/logout' do
      #binding.pry
      session.clear
      #binding.pry
      #redirect to home/landing page
      redirect '/'
    end 
  
  end 