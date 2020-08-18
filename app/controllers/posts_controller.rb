class PostsController < ApplicationController
    
    # READ
    
    # index route for all posts
      get '/posts' do
        #"all posts"
        @posts = Post.all
        #render all posts
        erb :'posts/index'
      end
    
      # CREATE
      #render a form to create a new post

      get '/posts/new' do
        if logged_in?
          erb :"posts/new"
        else 
          #show error message
          flash[:error] = "You must be logged in to create a post!"
          redirect "/"
        end 
      end 

      #NEED another route for create
      post "/posts" do
        #if params[:title] != "" && params[:description] != "" && params[:image_url] != ""
        #receive the params that the user input in the create new post form
        post = Post.new(title: params[:title], image_url: params[:image_url], description: params[:description], user_id: current_user.id)
        if post.save
          # ^ if valid input - .save trigger our validation
        # show post creation succes message
        flash[:message] = "Post created successfully"
        #redirect to the post show page
        redirect "/posts/#{post.id}"
        else
          # show post creation error message
          flash[:error] = "Post creation failed. Please fill out all inputs."
          redirect "/posts/new" 
        end 
      end 

      #ORDER MATTERS
    # show route for a single post
      get '/posts/:id' do
        @post = Post.find(params[:id])
        erb :"/posts/show"
      end 
    
    
    # UPDATE
    # edit button that takes to the form 
    # render an edit form
    # patch method/route that will update the post
    # create a link to edit form on post show page
    # get route to render a edit form
    get '/posts/:id/edit' do
      @post = Post.find(params[:id])
      erb :'/posts/edit'
    end 

    # 'use Rack::MethodOverride' in 'config.ru'
    # patch to send our params to and update new post (or resource)
    patch '/posts/:id' do
      @post = Post.find(params[:id])
      @post.update(title: params[:title], image_url: params[:image_url],
      description: params[:description])
      redirect "/posts/#{@post.id}"
    end 

    # DELETE
    #create a link to delete to delete on post show page
    # 'use Rack::MethodOverride' in 'config.ru'
    # delete route to delete our post
    delete '/posts/:id' do
      # we need the id to FIND the post to delete
      @post = Post.find(params[:id])
      @post.destroy
      redirect '/posts'
    end 
    
end 