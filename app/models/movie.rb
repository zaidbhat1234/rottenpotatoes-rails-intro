class Movie < ActiveRecord::Base
    def self.all_ratings
        return ['G','PG','PG-13','R']
    end
    
    def self.with_ratings(ratings_list, sort_by)
        #Get all movies with ratings in ratings_list
        #if ratings_list.nil? 
            #If no ratings have been selected then display movies with all ratings
            #hash = {}
            #Movie.all_ratings.each do |rating|
                #hash[rating] = 1
            #end
            #params[:rating] = hash
       
        #checked.each do |rating|
            #params[:rating] = true
        #end
        #return checked
        #end
        
        movies = Movie.where(:rating => ratings_list).order(sort_by)
        return movies 
    end
end
