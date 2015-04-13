require_relative 'contact'
require_relative 'rolodex'

require 'sinatra'

$rolodex= Rolodex.new

@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

get '/' do
  @crm_app_name = "My CRM"
  erb :index
end


get '/contacts' do
  erb :contacts
end


get '/contacts/new' do
  erb :addcontact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
end

# 7 HTTP RESTful Routes
# GET /contacts - index
# GET /contacts/:id - show

# GET /contacts/:id/edit - edit
# PUT /contacts/:id - update

# GET /contacts/new - new
# POST /contacts - create

# DELETE /contacts/:id - delete
