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
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'db/development.db',
  :encoding => 'utf8'
)


# define a route for the root of the site
get '/' do
  # render the views/index.erb template
	@tasks = TodoItem.all.order(:due)
	erb :todo
end

post '/' do
	TodoItem.create(description: params[:task], due: params[:date])
end
