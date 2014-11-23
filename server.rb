require 'sinatra'
require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: 'launcher_dj')
    yield(connection)
  ensure
    connection.close
  end
end

def song_list
  select_query = "SELECT * FROM songs"
  result = db_connection do |conn|
    conn.exec(select_query)
  end
  result.to_a
end

def complete?(array)
  array.each do |item|
    return false if item.nil? || item.empty?
  end
  true
end

def sanitize(song_name, artist, user_name, url)
  [song_name, artist, user_name, url]
end

def add_song_to_db(song_name, artist, user_name, url)
  return 'Please fill out all fields' unless complete?([song_name, artist, user_name, url])
  song_data = sanitize(song_name, artist, user_name, url)
  query = "INSERT INTO songs (song_name, artist, user_name, song_url, created_at)
    VALUES ('#{song_data[0]}', '#{song_data[1]}', '#{song_data[2]}', '#{song_data[3]}', now());"
  db_connection do |conn|
    conn.exec(query)
  end
  'Submission accepted'
end

get '/launcher_dj' do
  @song_list = song_list
  # binding.pry
  erb :index
end

post '/submission' do
  @title = params[:title]
  @artist = params[:artist]
  @url = params[:url]
  @username = params[:username]
  @message = add_song_to_db(@title, @artist, @username, @url)
  @song_list = song_list
  erb :index
end
