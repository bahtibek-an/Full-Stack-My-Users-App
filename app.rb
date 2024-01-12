require 'sinatra'
require_relative 'my_user_model.rb'

set :bind, '0.0.0.0'
set :port, '8080'
enable :sessions

get '/users' do
  user = User.new()
  @users = user.all()
  erb :index
end

# user yaratish
post '/users' do
  user = User.new()
  user_info = [params['firstname'], params['lastname'], params['age'], params['password'], params['email']]
  id = user.create(user_info)

  "#{id} id raqami ostida yangi foydalanuvchi yaratildi!"
end

# test sign in user
# curl -X POST -i -c ./cookie localhost:8080/sign_in -d "email=1234@gmail.com" -d "password=Parol1111"
post '/sign_in' do
  user = User.new()
  id = user.match(params['email'], params['password'])
  session[:user_id] = id[0][0]
  "#{id[0][0]} id foydalanuvchi o'z hisobiga kirdi"
end

# change data with session
# curl -X PUT -b ./cookie -i localhost:8080/users -d "password=Ozodbek2008"
put '/users' do 
  user = User.new()
  id = session[:user_id]
  if id
    user.update(id, 'password', params['password'])
    "ma'lumot omadli o'zgartirildi"
  else
    "hatolik: hisobga hali kirmagansiz"
  end
end

delete '/sign_out' do 
  user = User.new()
  id = session[:user_id]
  if id
    session.delete(user_id)
  else
    "hatolik: hisobga hali kirmagansiz"
  end
end

delete '/users' do 
  user = User.new()
  id = session[:user_id]
  if id
    session.destroy(id)
    session.delete(user_id)
  else
    "hatolik: hisobga hali kirmagansiz"
  end
end

# Ozodbek|Bakhriddinov|16|parol321|email@gmail.com       
# Doniyor|Fahriddinov|28|Parol1111|1234@gmail.com 