class SinatraApp < Sinatra::Base

  set :public_folder, 'public'

  get '/' do
    haml :index
  end

end
