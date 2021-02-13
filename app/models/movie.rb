class Movie < ActiveRecord::Base
    attr_accessible :title, :rating, :description, :release_date
    def self.with_ratings(ratings_list)
        %w(G PG PG-13 NC-17 R) #Create an array of strings
     # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
     #  movies with those ratings
     # if ratings_list is nil, retrieve ALL movies
    
    end
end
