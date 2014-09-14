files = %w(rubygems sinatra eventmachine em-websocket sinatra/base thin sequel sqlite3 json haml)
files.each{|e| require e}

require "./env.rb"
require "./app/controllers/application_controller.rb"
require './app/lib/audio_garden.rb'
require './db/schema.rb'
require './app/models/note.rb'


AudioGarden.run AudioGarden::App.new
