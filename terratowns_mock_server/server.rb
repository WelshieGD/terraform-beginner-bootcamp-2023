require 'sinatra'
require 'json'
require 'pry'
require 'active_model'

# We will mock having a state or database for this development server
# BY setting  a global variable. You would never use a global variable in a production servers.
$home = {}


# This is a ruby class with which includes validations from ActiveRecord.
# This will represent our Home resources as a ruby object.
class Home
  # ActiveModel is part of Ruby on Rails
  # It is used as an ORM. It has a mdoule within ActiveModel that provides validations.
  # The production terratowns server is rails and uses similar if not identical validations
  # https://guides.rubyonrails.org/active_model_basics.html
  # https://guides.rubyonrails.org/active_record_validations.html
  include ActiveModel::Validations
  # Creatre some initial attrivutes to store on this object
  # This will set a getter and a setter
  # e.g.
  # home = new Home()

  attr_accessor :town, :name, :description, :domain_name, :content_version
  
    # https://guides.rubyonrails.org/active_record_validations.html#inclusion
    # gamers-grot
    # cooker-cove
  validates :town, presence: true, inclusion: { in:[
    'cooker-cove',
    'melomaniac-mansion',
    'video-valley',
    'the-nomad-pad',
    'gamers-grotto'
    ] }
  
  # Visible to all users
  validates :name, presence: true

    # Visible to all users
  validates :description, presence: true

  # We want to lock this down to only be from cloudfront
  validates :domain_name, 
    format: { with: /\.cloudfront\.net\z/, message: "domain must be from .cloudfront.net" }
    # uniqueness: true, 
# content version has to be an integer (in Prod check for incrementation)
  validates :content_version, numericality: { only_integer: true }
end

# We are extending a class from Sinatra::Base to turn this generic class to utilise the sinatra web-framework
class TerraTownsMockServer < Sinatra::Base

  def error code, message
    halt code, {'Content-Type' => 'application/json'}, {err: message}.to_json
  end

  def error_json json
    halt code, {'Content-Type' => 'application/json'}, json
  end

  def ensure_correct_headings
    unless request.env["CONTENT_TYPE"] == "application/json"
      error 415, "expected Content_type header to be application/json"
    end

    unless request.env["HTTP_ACCEPT"] == "application/json"
      error 406, "expected Accept header to be application/json"
    end
  end

  # Return a hard coded access token
  def x_access_code
    return '9b49b3fb-b8e9-483c-b703-97ba88eef8e0'
  end

  def x_user_uuid
    return 'e328f4ab-b99f-421c-84c9-4ccea042c7d1'
  end

  def find_user_by_bearer_token
    auth_header = request.env["HTTP_AUTHORIZATION"]
    # Check if authorisation header exists
    if auth_header.nil? || !auth_header.start_with?("Bearer ")
      error 401, "a1000 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # Does the token match the one in our database - if we can't find it or doesn't match then return an error
    # code = access_code = token
    code = auth_header.split("Bearer ")[1]
    if code != x_access_code
      error 401, "a1001 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    if params['user_uuid'].nil?
      error 401, "a1002 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    unless code == x_access_code && params['user_uuid'] == x_user_uuid
      error 401, "a1003 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
  end

  # CREATE
  post '/api/u/:user_uuid/homes' do
    ensure_correct_headings()
    find_user_by_bearer_token()
    puts "# create - POST /api/homes"

    # a begin/rescue if a try/catch, if an error occurs then rescue it
    begin
      # Sinatra does not automatically pass json body as params so need to manually parse it
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Assign the payload to variables to make it easier to work with the code
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]
    town = payload["town"]

    # print out the variables to the console to make it easier to see or debug what we have inputed into this endpoint
    puts "name #{name}"
    puts "description #{description}"
    puts "domain_name #{domain_name}"
    puts "content_version #{content_version}"
    puts "town #{town}"


    # Create a new Home model and set attributes
    home = Home.new
    home.town = town
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version
    
    # Ensure validation cchecks pass otherise return error 
    unless home.valid?
      # REeturn error back as joson
      error 422, home.errors.messages.to_json
    end

    # geneerate a uudi at random
    uuid = SecureRandom.uuid
    puts "uuid #{uuid}"
    # we will mock our data to our back database as a global variable
    $home = {
      uuid: uuid,
      name: name,
      town: town,
      description: description,
      domain_name: domain_name,
      content_version: content_version
    }

    return { uuid: uuid }.to_json
  end

  # READ
  get '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# read - GET /api/homes/:uuid"

    # checks for house limit

    content_type :json
    # doe sthe uuid for the home match the one in the database
    if params[:uuid] == $home[:uuid]
      return $home.to_json
    else
      error 404, "failed to find home with provided uuid and bearer token"
    end
  end

  # UPDATE
  # very similar to create 
  put '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# update - PUT /api/homes/:uuid"
    begin
      # Parse JSON payload from the request body
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]

    unless params[:uuid] == $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    home = Home.new
    home.town = $home[:town]
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version

    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    return { uuid: params[:uuid] }.to_json
  end

  # DELETE
  # delete from our mock database
  delete '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# delete - DELETE /api/homes/:uuid"
    content_type :json

    if params[:uuid] != $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    $home = {}
    { message: "House deleted successfully" }.to_json
  end
end

# This will run our web server
TerraTownsMockServer.run!