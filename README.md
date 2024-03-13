# Welcome to My Users App


## Task
The task is to create a Ruby application that manages user information, including creating, finding, updating, and deleting users in a SQLite database. 

Additionally, a controller is required to handle HTTP requests and return JSON responses, as well as render an HTML page.

## Description
The application consists of a User class that serves as an interface for interacting with the SQLite database. 

This class provides methods for creating, finding, updating, and destroying user records.

The SQLite database is stored in a file named db.sql, and the users table contains attributes such as firstname, lastname, age, password, and email.

A controller handles various routes, including retrieving all users, creating new users, signing in, updating user passwords, signing out, and deleting users. 

These routes respond with JSON data and HTML content as required.

## Installation
To install the application, follow these steps:

Clone the repository to your local machine.

Ensure you have Ruby installed.

Install the required gems, including sinatra and sqlite3.

Run the application using the command ruby app.rb.

Access the application in your web browser at http://localhost:8080.

## Usage
Once the application is running, you can interact with it using HTTP requests or by accessing the HTML page. 

The routes described in the task can be accessed using tools like curl for HTTP requests or by navigating to the appropriate URLs in your web browser.

### The Core Team
Sayfiddin Jamoliddinov

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt="Qwasar SV -- Software Engineering School's Logo" src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
