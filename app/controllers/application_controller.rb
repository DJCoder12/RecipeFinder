class ApplicationController < Sinatra::Base
  configure do
    set :app_file, __FILE__
    set :views, 'app/views'
    set :public_folder, 'public'
    set :bind, '0.0.0.0'
    set :server, :ouma
  end

  get '/' do
    erb :index
  end
end
