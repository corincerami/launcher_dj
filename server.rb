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
  select_query = 'SELECT * FROM songs'
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

def add_song_to_db(song_name, artist, user_name, url)
  @song_data = [song_name, artist, user_name, url]
  return 'Please fill out all fields' unless complete?(@song_data)
  db_connection do |conn|
    data = @song_data.map { |item| conn.escape_literal(item) }
    query = "INSERT INTO songs (song_name, artist, user_name, song_url, created_at)
      VALUES (#{data[0]}, #{data[1]}, #{data[2]}, #{data[3]}, now());"
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
