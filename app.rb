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

post '/delete' do
  TodoItem.find_by(task: params[:task]).destroy
  redirect '/'
end

# I couldn't get it to work without this, but I saw you showed Jon some way to do in class
# I tried <% unless task.due.blank? %> and some variations on it, but no luck
helpers do
  def blank?(x)
    x.nil? || x == ""
  end
end
