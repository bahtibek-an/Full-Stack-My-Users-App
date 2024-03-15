require 'sqlite3'

class User
  # Class attributes
  attr_accessor :id, :firstname, :lastname, :age, :email, :password

  # Initializes a new user
  def initialize(id = 0, firstname, lastname, age, email, password)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @age = age
    @email = email
    @password = password
  end

  # establish a connection to the database
  def self.connect_db
    begin
      @db = SQLite3::Database.open 'db.sql'
      @db.results_as_hash = true

      # Create the seusers table if it does not already exist
      @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            firstname STRING,
            lastname STRING,
            age INTEGER,
            email STRING,
            password STRING
            );
        SQL

    return @db
    rescue SQLite3::Exception => e
      puts "Error: #{e}"
    end
  end

  # Method to retrieve all users
  def self.all
    @db = connect_db
    users = @db.execute "SELECT * FROM users"
    @db.close
    return users
  end

   # Method to create a new user
   def self.create(user_info)
    @db = connect_db
    @db.execute "INSERT INTO users(firstname, lastname, age, email, password) VALUES (?, ?, ?, ?, ?)", user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:email], user_info[:password]

    user = User.new(user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:email], '')
    user.id = @db.last_insert_row_id
    @db.close
    return user
  end

  # Method to retrieve a user by ID
  def self.find(user_id)
    db = SQLite3::Database.new 'db.sql'
    user = db.execute('SELECT * FROM users WHERE id = ?', user_id.to_i) 
    
    db.close
  
    return nil if user.empty?
  
    user_info = User.new(user[0][0], user[0][1], user[0][2], user[0][3], user[0][4], user[0][5])
    user_info.id = user[0][0] 
  
    return user_info
  end

  # Method to delete a user
  def self.destroy(user_id)
    @db = connect_db
    @db.execute "DELETE FROM users WHERE id = ?", user_id
    @db.close
    return true
  end

  # Method to authenticate a user
  def self.authenticate(password, email)
    @db = connect_db
    user_data = @db.execute "SELECT * FROM users WHERE password = ? AND email = ?", password, email
    @db.close
    return user_data
  end

  # Method to update an attribute of a user
  def self.update(user_id, attribute, value)
    @db = connect_db
    @db.execute "UPDATE users SET #{attribute} = ? WHERE id = ?", value, user_id

    user_data = @db.execute "SELECT * FROM users WHERE id = ?", user_id
    @db.close
    return user_data
  end
end
