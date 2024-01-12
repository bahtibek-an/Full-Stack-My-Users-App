require 'sqlite3'

class User 
  def makeHash(array)
    hash = Hash.new()
    hash['firstname'] = array[0]
    hash['lastname'] = array[1]
    hash['age'] = array[2]
    hash['password'] = array[3]
    hash['email'] = array[4]

    return hash
  end

  # create
  def create(user_info)
      begin
        db = SQLite3::Database.open "my_first_app.db"
        db.execute "INSERT INTO users VALUES('#{user_info[0]}', '#{user_info[1]}', '#{user_info[2]}', '#{user_info[3]}', '#{user_info[4]}')"
    rescue SQLite3::Exception => e 
        puts "Exception occurred"
        puts e
    ensure
        id = db.last_insert_row_id
        db.close if db
      end
    end
    
    # get
    def get(user_id)
      begin
        db = SQLite3::Database.open "my_first_app.db"
        user = db.execute "SELECT * FROM users WHERE rowid=#{user_id}"
      rescue SQLite3::Exception => e 
        puts "Exception occurred"
        puts e
      ensure
        db.close if db
        return makeHash(user[0])
    end
  end

  # all
  def all
    begin
        db = SQLite3::Database.open "my_first_app.db"
        users = db.execute "SELECT * FROM users"
      rescue SQLite3::Exception => e 
        puts "Exception occurred"
        puts e
      ensure
        db.close if db
        hashArray = []
        for user in users
          hash = makeHash(user)
          hashArray.push(hash)
        end
          return hashArray
    end
  end

  # update
  def update(user_id, attribute, value)
    begin
      db = SQLite3::Database.open "my_first_app.db"
      db.execute "UPDATE users SET #{attribute}=#{value} WHERE rowid=#{user_id}"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
      p "OK"
    end
  end

  # destroy & delete
  def destroy(user_id)
    begin
      db = SQLite3::Database.open "my_first_app.db"
      db.execute "DELETE FROM users WHERE rowid=#{user_id}"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
      p "OK"
    end
  end

  def match(email, password)
    begin
      db = SQLite3::Database.open "my_first_app.db"
      id = db.execute "SELECT rowid FROM users WHERE email='#{email}' AND password='#{password}'"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
      return id
    end
  end

end
# user = User.new()

# test (:

# my exemple user at id "1"
# user.create(['Ozodbek', "Bakhriddinov", 16, 'parol321', 'email@gmail.com'])
# user.destroy(2)