class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    ratings = params[:ratings]
    @all_ratings = Movie.all_ratings
    
    #if ratings.nil?
      #ratings = @all_ratings
    #else
      #session[:ratings] = ratings #Save the checked boxes if its not nil
      #ratings = ratings.keys
    #end
    
    if !params[:ratings].nil?
      session[:ratings] = ratings 
    end
    
    if !params[:sort].nil?
      session[:sort] = params[:sort]
    end
      
    #@ratings_to_show = ratings
    #@movies = Movie.with_ratings(ratings)
    
    #Sorting by release date/title.
    sort_by = params[:sort]
    
    if (params[:ratings].nil? && !session[:ratings].nil?) || (params[:sort].nil? && !session[:sort].nil?)
      redirect_to movies_path("ratings" => session[:ratings], "sort" => session[:sort])
      
    elsif (params[:ratings].nil? && (session[:ratings].nil? or params[:commit]=='Refresh'))
      @ratings_to_show = Movie.all_ratings
      @movies = Movie.with_ratings(@ratings_to_show, session[:sort])
    
    else
      if !params[:ratings].nil?
        ratings = params[:ratings].keys
      else
        ratings = @all_ratings
      end
      if sort_by == 'title'
        @sort_by = sort_by
        #@movies = @movies.order(:title)
        @highlight = 'title'
      elsif sort_by=='release_date'
        @sort_by = sort_by
        #@movies = @movies.order(:release_date)
        @highlight = 'release_date'
      else
        @sort_by = ""
        @ratings_to_show = ratings
        #@movies = Movie.with_ratings(ratings)
        @highlight = nil
      end
      
      @ratings_to_show = ratings
      @movies = Movie.with_ratings(ratings, @sort_by)
    
      
    end
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end