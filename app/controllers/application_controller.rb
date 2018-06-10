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
    @allIngredients = Pantries.distinct.pluck(:name)

    @pantryToInput = {};
    Pantries.all.each do |entry|
      @pantryToInput[entry.name] = [entry.name, entry.amount, entry.expDate]
    end

    # puts @pantryToInput

    @recipeToInput = {};

    Recipes.all.each do |entry|
      @recipeToInput[entry.name] = {}
    end

    @recipes = Recipes.distinct.pluck(:name)
    @recipes.each do |recipe|
      @ingredientToInput = {}
      Recipes.where(name: recipe).each do |ingredient|
        @ingredientToInput[ingredient.ingredient] = ingredient.amount
      end
      @recipeToInput[recipe] = @ingredientToInput
    end

    @items = RecipeFinder.choose(0, 5, @pantryToInput, @recipeToInput, 7, [])

    puts @items

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
    amount = params['amount']
    expDate = params['date']

    Pantries.create(
      name: name,
      amount: amount,
      expDate: expDate,
    )

    redirect "/allIngredients"
  end

  
  get '/myrecipes' do
    @recipes = Recipes.distinct.pluck(:name)
    puts @recipes
    @ingredients = []
    @recipes.each do |recipe|
      @ingredients.push(Recipes.where(name: recipe))
    end

    erb :personalrecipes
  end

  post '/personalrecipes' do
    name = params['name']
    amount = params['amount']
    ingredient = params['ingredient']

    Recipes.create(
      name: name,
      amount: amount,
      ingredient: ingredient,
    )

    redirect '/myrecipes'
  end

  get '/suggestions' do
    @allIngredients = Pantries.distinct.pluck(:name)

    @hashList = RecipeApi.rec(@allIngredients)

    puts @hashlist

    erb :otherrecipes
  end

end
