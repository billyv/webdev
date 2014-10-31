# app.rb
# this is a simple Sinatra example app

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
# functionality of active record
require './models/TodoItem'
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
	@tasks = TodoItem.all.order(:due)
	erb :todo
end

post '/' do
	TodoItem.create(description: params[:task], due: params[:due])
  redirect '/'
end

get '/delete/:id' do
  TodoItem.find_by(id: params[:id]).destroy
  redirect '/'
end
