require "sinatra"
require "pg"
require "pry"


def db_connection
  begin
    connection = PG.connect(dbname: 'launch_playlist')

    yield(connection)

  ensure
    connection.close
  end
end

