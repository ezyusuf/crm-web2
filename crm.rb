require_relative 'contact'
require_relative 'rolodex'

require 'sinatra'

$rolodex= Rolodex.new

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

get "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
   erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end


delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

# 7 HTTP RESTful Routes
# GET /contacts - index
# GET /contacts/:id - show

# GET /contacts/:id/edit - edit
# PUT /contacts/:id - update

# GET /contacts/new - new
# POST /contacts - create

# DELETE /contacts/:id - delete
