# codecademy Learn RoR

# Getting Started
# lesson
# Get up and running quickly by building a Rails app from scratch.
# Exercises
### 1.Hello Rails I & II
$ rails new MySite
$ bundle install  # installs gems
$ rails server # rails s -b $IP -p $PORT >> https://community.c9.io/t/running-a-rails-app/1615

# 2.see prev  
# 3.Controller
# request/response cycle > https://www.codecademy.com/articles/request-response-cycle-static
# three parts to build a Rails app: a controller, a route, and a view

$ rails generate controller Pages 

# in app/controllers/messages_controller.rb

class PagesController < ApplicationController
    def home    # controller action
    end
end

# 4.Routes
# in config/routes.rb

get 'welcome' => 'pages#home'

# 5.Views
# in app/views/messages/home.html.erb

<div class="main">
    <div class="container">
        #..
    </div>
</div>

# in app/assets/stylesheets/pages.css.scss


# 6.Generalizations
# Using the request/response cycle as a guide, this has been our workflow when making a Rails app.
# Generate a new Rails app.
# Generate a controller and add an action.
# Create a route that maps a URL to the controller action.
# Create a view with HTML and CSS.
# Run the local web server and preview the app in the browser.

# Saving Data
# Learn how to add a database to a Rails app.. apps that save information

# Exercises
# 1.Request/Response Cycle
# https://www.codecademy.com/articles/request-response-cycle-dynamic

### 2.Model
# after creating
$ rails generate model Message
# migration file in db/migrate/

# can add column info or do in one shot
# http://edgeguides.rubyonrails.org/active_record_migrations.html

$ rake db:migrate   # updates the database with the new messages data model.

$ rake db:seed      # seeds the database with sample data .. https://codedecoder.wordpress.com/2013/04/25/rake-db-seed-in-rails/ .. https://codedecoder.wordpress.com/2013/04/25/what-is-rake-in-rails/

# if need to drop table
# http://stackoverflow.com/questions/4020131/rails-db-migration-how-to-drop-a-table

$ rails generate model  # creates model (app/models/message.rb) and migration (db/migration) files


# 3.Controller (& Route)
# add index action to app/controllers/messages_controller.rb

def index   # https://www.codecademy.com/articles/standard-controller-actions
    @messages = Messages.all    # The index action retrieves all messages from the database and stores them in variable @messages. .. The @messages variable is passed on to the view
end

# 4.View
# in app/views/messages/index.html.erb (web template) .. http://tutorials.jumpstartlab.com/topics/better_views/erb_and_haml.html

<% @messages.each do |message| %>   # iterates through each message in @messages array created in the Messages controller's index action.
<div class="message">
    <p class="content"><%= message.content %></p>   # display its content and the time when it was created.
    <p class="time"><%= message.created_at %></p>
</div>
<% end %>

# Rather than write the same HTML over and over again for each message, .. use web templates to loop through and display data from the database.

# 5.Create messages I & II
#  use the new and create actions ..  create a route that maps requests to messages/new to the Message controller's new action
 
 get 'messages/new' => "messages#new"
    
# in Messages controller

def new
    @message = Message.new
end

# add route to map requests to the Message controller's create action

post 'messages' => 'messages#create'

# add private method (action)

private
def message_params
    params.require(:message).permit(:content)
end

# add the create action

def create
    @message = Message.new(message_params)  # ?? message_params
    if @message.save
        redirect_to 'messages'
    else
        render 'new'
    end
end

# in app/views/messages/new.html.erb

<%= form_for(@message) do |f| %>
    <div class="field">
        <%= f.label :message %><br>
        <%= f.text_area :content %>
    </div>
    <div class="actions">
        <%= f.submit "Create" %>
    </div>
<% end %>

$ rails console     # ?? review

# in app/views/messages/index.html.erb add ..

<%= link_to 'New Message', "messages/new" %>

# 6.Create messages II
# https://www.codecademy.com/articles/request-response-cycle-forms
# see previous

# 7.Generalizations
# -A model represents a table in the database.
# -A migration is a way to update the database with a new table, or changes to an existing table.
# -Rails provides seven standard controller actions for doing common things such as display and create data
# -Data can be displayed in the view using ERB web templating.
# -Data can be saved into the database using a web form.
