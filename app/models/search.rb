class Search
   def self.search(keyword) 
     
      Scoreboard.where('name_of_organization LIKE ?', "%#{keyword}%") +
       User.where('name LIKE ?', "%#{keyword}%") 
   end
end