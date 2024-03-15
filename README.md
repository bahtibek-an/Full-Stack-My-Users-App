## Task

The task involves creating a simple web application, My User App, that implements the Model-View-Controller (MVC) architecture.
The primary goal is to manage user information in a SQLite database. The challenge lies in implementing various routes for user creation, retrieval, updating, and deletion, as well as additional features like user sign-in and sign-out.

## Description

Description
The project is organized into three main components:

Model (my_user_model.rb):

Implements the User class to interact with the SQLite database.
Manages user creation, retrieval, updating, authentication, and deletion.
Controller (app.rb):

Defines routes to handle HTTP requests and connect the user interface with the data model.
Implements functionality for creating, retrieving, updating, and deleting users, as well as user sign-in and sign-out.
Utilizes sessions for tracking user authentication.
Views (views directory):

Contains the index.erb file, an HTML template to display a list of users.
Provides a basic user interface for viewing user information.

## Installation

To install the project, follow these steps:

Clone the Repository:

git clone <repository-url>
Install Required Gems:

bundle install

## Usage

To run the application:
ruby app.rb
Access the application in your web browser at http://localhost:8080.
Routes
GET / :
Displays a list of users in an HTML table.
GET /users :
Returns a JSON representation of all users (excluding passwords).
POST /sign_in :
Handles user sign-in. Expects email and password parameters.
POST /users :
Creates a new user or performs user sign-in based on provided parameters.
PUT /users :
Updates the password of the currently signed-in user.
DELETE /sign_out :
Signs out the currently authenticated user.
