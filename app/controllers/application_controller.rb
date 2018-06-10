class ApplicationController < Sinatra::Base
  configure do
    set :app_file, __FILE__
    set :views, 'app/views'
    set :public_folder, 'public'
    set :bind, '0.0.0.0'
    set :server, :ouma
  end

  # ActiveRecord::Base.establish_connection(
  #   :adapter => "sqlite3",
  #   :database => "db/development.sqlite"
  # )


  get '/' do
    erb :index
  end

  get '/home' do
    erb :home
  end

  post '/form' do
    name = params['name']
    expDate = params['date']

    Pantries.create(
      name: name,
      expDate: expDate,
    )

    redirect to "/home"
  end


end
