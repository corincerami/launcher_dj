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

# user to be able to post these above variables in a form
# pull those from params and insert into db query
# build another query to select all songs from table
# deliver those songs to .erb file

query = "INSERT INTO songs (song_name, artist, user_name, song_url, created_at)
    VALUES ('#{song_name}', '#{artist}', '#{user_name}', '#{url}', now());"

# add song to the database
db_connection do |conn|
    conn.exec(query)
end
