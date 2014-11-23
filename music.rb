require "pg"
require "pry"


def db_connection
  begin
    connection = PG.connect(dbname: 'launcher_dj')

    yield(connection)

  ensure
    connection.close
  end
end

song_name = "Come On, Eileen"
artist = "Dexys Midnight Runner"
user_name = "Chris Magic Wand"
url = "https://www.youtube.com/watch?v=oc-P8oDuS0Q"

query = "INSERT INTO songs (song_name, artist, user_name, song_url, created_at)
    VALUES ('#{song_name}', '#{artist}', '#{user_name}', '#{url}', now());"

# add song to the database
db_connection do |conn|
    conn.exec(query)
end
