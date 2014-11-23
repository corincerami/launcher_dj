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

# user to be able to post these above variables in a form
# pull those from params and insert into db query
# deliver those songs to .erb file

# *** this query needs to be in the post request block with each variable pulling from params
# insert_query = "INSERT INTO songs (song_name, artist, user_name, song_url, created_at)
#     VALUES ('#{song_name}', '#{artist}', '#{user_name}', '#{url}', now());"


# *** this query needs to be in the get request block to be sent to index.erb
select_query = "SELECT * FROM songs"

def query_conn(query)
  result = nil
  # send relevant query to the database
  db_connection do |conn|
      result = conn.exec(query)
  end
  result.to_a
end

puts query_conn(select_query)
