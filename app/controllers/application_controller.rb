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


  get '/home' do
    # @allIngredients = Pantries.all
    # @allIngredients.each do |ingredient|
    #   puts ingredient.name
    # end
    erb :home
  end

  get '/' do
    erb :home
  end

  get '/allIngredients' do
    @allIngredients = Pantries.all
    erb :allIngredients
  end

  post '/addIngredients' do
    name = params['name']
    expDate = params['date']

    Pantries.create(
      name: name,
      expDate: expDate,
    )

    redirect "/allIngredients"
  end


  get '/suggestions' do
    @allIngredients = Pantries.all
    @recipes= Recipes.all
    erb :suggestions
  end
                                  


end
