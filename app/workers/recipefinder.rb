class RecipeFinder
  def self.choose(day,lim,pantry,recipes,days,rlist)
    if day == days
      return [days,rlist]
    end

    mday = day
    mlist = rlist
    use = usablelist(lim,pantry,recipes,day,rlist)
    nuse = []
    i = rlist.length
    if i > 0
      while i-1 >= 0 && i> rlist.length-lim do
        nuse.push(rlist[i-1])
        i-=1
      end

    end
  
    if use.length > 0 || day >= days
      use.each do |item|
        if !nuse.include? item
          rl = Marshal.load(Marshal.dump(rlist))
          rl.push(item)
          c = choose(day+1,lim,pantry,recipes,days,rl)
          if c[0] >= days
            return c
          end

          if mday < c[0]
            mday = c[0]
            mlist = c[1]
          end

        end

      end
    
    end
    
  return [mday,mlist]

  end

  def self.usablelist(lim,pantry,recipes,day,rlist)
    upantry = Hash.new
    pantry.each do |item|
      upantry[item] =0
    end

    rlist.each do |item|
      recipes[item].each do |ing|
        upantry[ing]+=recipes[item][ing]
      end
    end
    use = []
    nuse =[]
    recipes.each do |item, value|
      if usable(lim,pantry,recipes[item],day,upantry) == true
        use.push(item)
      else
        nuse.push(item)
      end
    end
    return use
  end

  def self.usable(lim,pantry,recipe,day,upantry)
    recipe.each do |item| 
      if !pantry.include? item
        return false
      elsif pantry[item][1] < recipe[item]+upantry[item]
        return false
      elsif pantry[item][2] < day
        return false
      end
    end

    return true
  end

end
