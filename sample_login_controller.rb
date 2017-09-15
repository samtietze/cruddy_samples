get '/login' do
  user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/restricted_area'
  else
    erb :login
  end
end


# also this:

get '/login' do
  erb :'/sessions/new'
  # session.inspect
end

post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    status 401
    @errors = ["Bad username/password combo"]
    erb :'/sessions/new'
  end
end

delete '/sessions' do
  session[:user_id] = nil
  redirect '/'
end
