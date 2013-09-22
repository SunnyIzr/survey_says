require "sinatra"
require_relative 'config'
require_relative 'session_helper'

enable :sessions

get "/" do
  redirect "/login"
end

get "/create_survey_form" do
  if logged_in?
    erb :create_survey_form
  else
    redirect "/login"
  end
end

post "/create_survey_form" do
  survey = Survey.create(title: params[:survey_title])
  survey.user = get_user_from_session
  survey.save
  @survey_title = params[:survey_title]
  @question_number = params[:question_number]
  redirect "/surveys/#{survey.id}/#{@survey_title}/#{@question_number}/questions/new"
end

get "/surveys/:survey_id/:survey_title/:question_number/questions/new" do
  @survey_title = params[:survey_title]
  @question_number = params[:question_number]
  @survey_id = params[:survey_id]
  erb :create_survey_questions
end

post "/surveys/:survey_id/questions" do
  @survey = Survey.find(params[:survey_id])
  params[:question].each do |question|
    q = Question.create(:question => question)
    q.survey = @survey
    q.save
  end

  redirect "#{params[:survey_id]}/created_new_survey"
end

get "/surveys/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  @survey_id = params[:survey_id]
  erb :display_survey
end

get "/surveys/all_responses/:survey_id" do
  @survey = Survey.find(params[:survey_id])
  erb :show_survey
end

post "/surveys/:survey_id/responses" do
  survey_questions = Survey.find(params[:survey_id]).questions
  params[:response].each_with_index do |response, qid|
    new_response = Response.create(:response_text => response)
    new_response.question = survey_questions[qid]
    new_response.save
  end
  erb :success
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.create(params)
  if user
    redirect "/#{user.id}"
  else
    "Error signing up"
  end

end

get '/:survey_id/created_new_survey' do
  erb :created_new_survey
end

get '/login' do
  erb :login
end

post '/login' do
  login(params[:email], params[:password])
  if logged_in?

    #{User.find_by_email(params[:email]).id}
        # puts "WHERE AM I?? \n \n"
    redirect "/#{User.find_by_email(params[:email]).id}"
  else
    redirect '/signup'
  end
end

get '/clear' do
  session.clear
  redirect '/'
end

get "/:user_id" do
  @surveys = Survey.find_all_by_user_id(params[:user_id])
  @user_name = User.find(params[:user_id])
  erb :user_page
end


