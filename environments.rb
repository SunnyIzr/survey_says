require 'active_record'
require 'sinatra'
require 'sinatra/activerecord'

configure :development do
	set :database, 'sqlite3:///dev.db'
end

configure :production do 
	ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end