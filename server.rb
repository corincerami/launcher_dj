require 'sinatra'
require 'pg'

def sql_magic_goes_here
  []
end

def add_song_to_db(title, artist, url, username)
end

songs_list = sql_magic_goes_here

get '/launcher_dj' do
  @songs_list = songs_list
  erb :index
end

post '/submission' do
  @title = params[:title]
  @artist = params[:artist]
  @url = params[:url]
  @username = params[:username]
  @message = add_song_to_db(@title, @artist, @url, @username)
  erb :index
end
