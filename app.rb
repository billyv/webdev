# app.rb
# this is a simple Sinatra example app

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
# functionality of active record
require './models/TodoItem'
require './models/TodoUser'
# set up active record for database
if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
  )
end



# define a route for the root of the site
get '/' do
  # render the views/index.erb template
	@users = TodoUser.all.order(:name)
	erb :index
end

post '/' do
  @user = TodoUser.create(name: params[:name])
  redirect '/'
end

get '/:name' do
  @user = TodoUser.find_by(name: params[:name])
  @tasks = @user.todo_items.order(:due)
  erb :todo_list
end

post '/:name' do
  userID = TodoUser.find_by(name: params[:name]).id
	TodoItem.create(description: params[:task], due: params[:due], todo_user_id: userID)
  redirect "/#{params[:name]}"
end

get '/:name/delete' do
  TodoUser.find_by(name: params[:name]).destroy
  redirect '/'
end

get '/:name/delete/:id' do
  TodoItem.find_by(id: params[:id]).destroy
  redirect "/#{params[:name]}"
end
