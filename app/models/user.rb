class User < ActiveRecord::Base
    has_many :posts
  
    # has a built in validator
    has_secure_password
  
  end 