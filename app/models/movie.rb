class Movie < ActiveRecord::Base
    def self.all_ratings
        return ['G','PG','PG-13','R']
    end
    
    def self.with_ratings(ratings_list)
        #Get all movies with ratings in ratings_list
        if params[:ratings].nil? 
            #If no ratings have been selected then display movies with all ratings
            hash = {}
            Movie.all_ratings.each do |rating|
                hash[rating] = 1
            end
            params[:rating] = hash
        end
        
        
    end
end
