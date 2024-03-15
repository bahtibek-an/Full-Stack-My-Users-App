require 'sinatra'
require 'json'
require_relative 'my_user_model.rb'

class MyUserApp < Sinatra::Base
  configure do
    # Application configuration
    set :port, 8080
    set :bind, '0.0.0.0'
    enable :sessions
  end

  # Homepage to display all users
  get '/' do
    @users = User.all
    erb :index
  end

  # Endpoint to retrieve all users in JSON format
  get '/users' do
    content_type :json
    users = User.all.map { |user| user.slice("firstname", "lastname", "age", "email") }
    users.to_json
  end

  # Endpoint for user authentication
  post '/sign_in' do
    verify_user = User.authenticate(params[:password], params[:email])
    if !verify_user.empty?
      status 200
      session[:user_id] = verify_user[0]["id"]
      verify_user[0].to_json
    else
      status 401
    end
  end

  # Endpoint for creating a new user
  
  post '/users' do 
    if params[:firstname]
      user = create_and_return_user(params)
    else
      user = authenticate_and_return_user(params)
    end
    user.to_json
  end
  
  def create_and_return_user(params)
    created_user = User.create(params)
    new_user = User.find(created_user.id)
    {
      firstname: new_user.firstname,
      lastname: new_user.lastname,
      age: new_user.age,
      password: new_user.password,
      email: new_user.email
    }
  end
  
  def authenticate_and_return_user(params)
    authenticated_user = User.authenticate(params[:password], params[:email])
    if authenticated_user
      status 200
      session[:user_id] = authenticated_user.id
    else
      status 401
    end
    authenticated_user
  end

  # Endpoint for updating a user's password
  put '/users' do
    user = User.find(session[:user_id])
    User
    .update(user.id, 'password', params[:password])
    status 200
    user_info = {
      firstname: user.firstname,
      lastname: user.lastname,
      age: user.age,
      password: user.password,
      email: user.email
    }.to_json
  end

  # Endpoint for deleting a user
  delete '/users' do
    user_id = session[:user_id]
    if user_id.nil?
      unauthorized_response
    else
      destroy_user_and_clear_session(user_id)
    end
  end

  # Endpoint for user logout
  delete '/sign_out' do
    session[:user_id] = nil if session[:user_id]
    status 204
  end

  run! if __FILE__ == $PROGRAM_NAME
end
