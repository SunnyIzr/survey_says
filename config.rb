require 'sinatra'
require "sinatra/activerecord"
require_relative 'models/question'
require_relative 'models/survey'
require_relative 'models/response'
require_relative 'models/user'
require_relative 'survey_controller'

# set :database, "sqlite3///db/survey_says.db"

# ENV['DATABASE_URL'] ||= "postgres://localhost/survey_says_development"
# set :database, ENV['DATABASE_URL']


set :database, "sqlite3:///db/survey_says.db"
