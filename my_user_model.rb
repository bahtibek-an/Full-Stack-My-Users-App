require 'sqlite3'

class UserDataManager
  def add(user_data)
    database = SQLite3::Database.open 'db.sql'
    new_data = user_data.split(',').map(&:strip)
    sql_query = 'INSERT INTO users(firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?);'
    database.execute(sql_query, new_data)
    result = database.execute 'SELECT last_insert_rowid();'
    result.flatten.first
  ensure
    database.close
  end

  def retrieve(user_id)
    database = SQLite3::Database.open 'db.sql'
    id = user_id.to_i
    sql_query = 'SELECT * FROM users WHERE user_id = ?'
    result = database.execute(sql_query, id)
    user_info = result.map do |row|
      {
        user_id: row[0],
        firstname: row[1],
        lastname: row[2],
        age: row[3],
        email: row[5]
      }
    end
    user_info
  ensure
    database.close
  end

  def retrieve_all
    database = SQLite3::Database.open 'db.sql'
    begin
      result = database.execute('SELECT * FROM users')
      users_info = result.map do |row|
        {
          user_id: row[0],
          firstname: row[1],
          lastname: row[2],
          age: row[3],
          password: row[4],
          email: row[5]
        }
      end
      users_info
    ensure
      database.close
    end
  end

  def amend(user_id, attribute, value)
    database = SQLite3::Database.open 'db.sql'
    id = user_id.to_i
    att = attribute
    val = value
    sql_query = "UPDATE users SET #{att} = ? WHERE user_id = ?"
    database.execute(sql_query, val, id)
    result = database.execute "SELECT * FROM users WHERE user_id = #{id}"
    user_info = result.map do |row|
      {
        user_id: row[0],
        firstname: row[1],
        lastname: row[2],
        age: row[3],
        email: row[5]
      }
    end
    user_info
  ensure
    database.close
  end

  def erase(user_id)
    database = SQLite3::Database.open 'db.sql'
    id = user_id.to_i
    sql_query = 'DELETE FROM users WHERE user_id = ?'
    database.execute(sql_query, id)
  ensure
    database.close
  end
end
