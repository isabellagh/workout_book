class PostsController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'posts/index'
  end

  get '/posts/new' do
    if logged_in?
      erb :"posts/new"
    else 
      flash[:error] = "You must be logged in to create a post!"
      redirect "/"
    end 
  end 

  post "/posts" do
    post = Post.new(title: params[:title], image_url: params[:image_url], description: params[:description], user_id: current_user.id)
    if post.save
      flash[:message] = "Post created successfully"
      redirect "/posts/#{post.id}"
    else
      flash[:error] = "Post creation failed. Please fill out all inputs."
      redirect "/posts/new" 
    end 
  end 

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :"/posts/show"
  end 
  
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    if authorized_to_edit?(@post)
      erb :'/posts/edit'
    else 
      flash[:error] = "Not authorized to edit that post!"
      redirect "/posts"
    end 
  end 

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(title: params[:title], image_url: params[:image_url],
    description: params[:description])
    redirect "/posts/#{@post.id}"
  end 

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    redirect '/posts'
  end     
end 