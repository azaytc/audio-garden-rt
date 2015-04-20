module AudioGarden
  class App < Sinatra::Base
    set :public_folder, 'public'
    set :views, 'app/views'

    get '/' do
      haml :index
    end
  end
end
