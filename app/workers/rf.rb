require 'unirest'

def get_ing(recipe,goodr)
  id=goodr[recipe]["id"]

  tot="https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/#{id}/information"
  
  response2 = Unirest.get tot,  
  headers:{
    "X-Mashape-Key" => "sG9AOGU1PGmsh1LcD70qUsRNxFeSp14HYasjsnWZVIi4A5UeuS",
    "X-Mashape-Host" => "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
  }
  r= response2.body["extendedIngredients"]
  inglist=[]
  r.each do |ing|
    inglist.push(ing["name"])
    #puts ing["name"]
  end
  return inglist
end
def rec(ing3)
  ing2 = ["apples","flour","sugar","sardines","ground+beef","lentil","squash","pasta","rice", "chicken", "bread","egg","carrot","butter","tomato","bread","cumin","grean+beans","curry+powder", "olive+oil","pepper","salt"]


  ing2 =["apples","banana", "grapes", "oranges", "pineapple", "strawberries", "blueberries", "raisins", "bell+peppers", "carrots", "cabbage", "lettuce", "onion", "potatoes", "tomatoes", "corn", "canned+tomatoes", "bread", "cereal", "crackers", "oatmeal", "pasta", "rice", "beans", "ground+beef", "chicken+breast", "eggs", "almonds", "peanut+butter", "pork+loin+chops", "salmon", "tuna", "turkey", "cheddar+cheese", "frozen+yogurt", "milk", "olive+oil", "mayonnaise", "canola+oil", "butter", "pepper", "chicken+broth", "chili+powder", "cinnamon", "garlic", "italian+seasoning", "mustard", "rosemary", "thyme", "vanilla", "vinegar", "sugar", "brown+sugar"]
  response2 = Unirest.get "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/887/information",
    headers:{
      "X-Mashape-Key" => "sG9AOGU1PGmsh1LcD70qUsRNxFeSp14HYasjsnWZVIi4A5UeuS",
      "X-Mashape-Host" => "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
    }
  response2.body

  response2 = Unirest.get "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/887/information",
    headers:{
      "X-Mashape-Key" => "sG9AOGU1PGmsh1LcD70qUsRNxFeSp14HYasjsnWZVIi4A5UeuS",
      "X-Mashape-Host" => "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
    }
  response2.body



  ing = ["ground+beef","apples","carrots","pasta","butter","curry+powder","lentils"]
  ing = ing3
  tot = ing[0]
  i = 1
  while i < ing.length
    tmp =""
    if i != 0
      tmp+="%2C"
    end

    #puts ing[i]
    tmp+=ing[i]
    tot+=tmp
    i+=1

  end

  search = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex?includeIngredients="+tot+"&limitLicense=false&type=main+course&ranking=0&offset=0&number=1000&minAlcohol=0&mincaffeine=0&mincopper=0&mincalcium=0&mincholine=0&mincholesterol=0&minfluoride=0&minSaturatedFat=0&minVitaminA=0&minvitaminc=0&minvitamind=0&minvitamine=0&minvitamink=0&minvitaminb1=0&minvitaminb2=0&minvitaminb3=0&minvitaminb5=0&minvitaminb6=0&minvitaminb12=0&minFiber=0&minfolate=0&minfolicacid=0&miniodine=0&miniron=0&minmagnesium=0&minmanganese=0&minphosphorus=0&minpotassium=0&minselenium=0&minsodium=0&minSugar=0&minzinc=0"
  #real ="https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex?includeIngredients=apples%2Cflour%2Csugar%2Csardines%2Cground+beef%2Clentil%2Csquash%2Cpasta%2Crice%2C+chicken%2C+bread%2Cegg%2Ccarrot%2Cbutter%2Ctomato%2Cbread%2Ccumin%2Cgrean+beans%2Ccurry+powder%2C+olive+oil%2Cpepper%2Csalt&limitLicense=false&type=main+course&ranking=0&offset=0&number=1000&minAlcohol=0&mincaffeine=0&mincopper=0&mincalcium=0&mincholine=0&mincholesterol=0&minfluoride=0&minSaturatedFat=0&minVitaminA=0&minvitaminc=0&minvitamind=0&minvitamine=0&minvitamink=0&minvitaminb1=0&minvitaminb2=0&minvitaminb3=0&minvitaminb5=0&minvitaminb6=0&minvitaminb12=0&minFiber=0&minfolate=0&minfolicacid=0&miniodine=0&miniron=0&minmagnesium=0&minmanganese=0&minphosphorus=0&minpotassium=0&minselenium=0&minsodium=0&minSugar=0&minzinc=0"

  response = Unirest.get search,
    headers:{
    "X-Mashape-Key" => "sG9AOGU1PGmsh1LcD70qUsRNxFeSp14HYasjsnWZVIi4A5UeuS",
      "X-Mashape-Host" => "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
  }
  #puts response.body
  stuff = response.body
  #puts stuff.keys
  goodr = Hash.new
  recipes= stuff["results"]
  #puts stuff["results"][0]
  recipes.each do |item|
    if item["missedIngredientCount"] == 0
      goodr[item["title"]]=item
     #puts item["title"]
    end
  end
  puts "done find"
  #puts goodr.keys[1]
  #get_ing(goodr.keys[1],goodr)
  inrec = Hash.new
  puts "here"
  ks = goodr.keys
  i =0
  while i<ks.length
    #puts ks[i]
    inrec[goodr.keys[i]] = get_ing(goodr.keys[i],goodr)
    i+=1
  end
  return [inrec,goodr]
end
#ing = ["cow"]
#i=rec(ing)
