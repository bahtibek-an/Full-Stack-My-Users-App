require 'sinatra'
require 'json'
require_relative 'my_user_model'

user = User.new

# Retrieve all users (without passwords)
get '/users' do
  content_type :json
  user.all.to_json
end

# Create a new user
post '/users' do
  user_info = JSON.parse(request.body.read)
  user_id = user.create(user_info)
  content_type :json
  user.find(user_id).to_json
end

# Sign in
post '/sign_in' do
  credentials = JSON.parse(request.body.read)
  user_info = user.all.find { |u| u[:email] == credentials['email'] && u[:password] == credentials['password'] }
  session[:user_id] = user_info[:id] if user_info
  content_type :json
  user_info.to_json
end

# Update user password
put '/users' do
  protected!
  user_info = JSON.parse(request.body.read)
  user.update(session[:user_id], 'password', user_info['password'])
  content_type :json
  user.find(session[:user_id]).to_json
end

# Sign out
delete '/sign_out' do
  session.clear
  status 204
end

# Delete user
delete '/users' do
  protected!
  user.destroy(session[:user_id])
  session.clear
  status 204
end

helpers do
  def protected!
    halt 401, 'Unauthorized' unless session[:user_id]
  end
end
