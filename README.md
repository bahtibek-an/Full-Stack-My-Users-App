# Description

In this project we will implement a very famous architecture: MVC (Model View Controller).

# Task

Create a class User, it will be your interface in order to

create user
find user
get all users
update user
destroy user in sqlite.
You will use the gem sqlite3. The sqlite filename will be named db.sql.

Your table will be name users and will have multiple attributes:

firstname as string
lastname as string
age as integer
password as string
email as string
Your class will have the following methods:

def create(user_info) It will create a user. User info will be: firstname, lastname, age, password and email And it will return a unique ID (a positive integer)

def find(user_id) It will retrieve the associated user and return all information contained in the database.

def all It will retrieve all users and return a hash of users.

def update(user_id, attribute, value) It will retrieve the associated user, update the attribute send as parameter with the value and return the user hash.

def destroy(user_id) It will retrieve the associated user and destroy it from your database.

# Installation

# Usage