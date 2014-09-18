# app.rb
# this is a simple Sinatra example app

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

# define a route for the root of the site
get '/' do
  # render the views/index.erb template
	data = File.read('todolist.txt')
	@lines = data.split("\n").map do |line|
		line.split(' - ')
	end
	erb :todo
end

post '/' do
	File.open('todolist.txt', 'a') do |file|
		file.puts "#{params[:task]} - #{params[:date]}"
	end
end
