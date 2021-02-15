class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    ratings = params[:ratings]
    @all_ratings = Movie.all_ratings
    
    if ratings.nil?
      ratings = @all_ratings
    else
      ratings = ratings.keys
    end
        
    @ratings_to_show = ratings
    
    #Sorting by release date/title.
    sort_by = params[:sort]
    @sort_by=""
    if sort_by == 'title'
      @sort_by = sort_by
      #@movies = Movie.order(:title)
      @highlight = 'title'
    elsif sort_by=='release_date'
      @sort_by = sort_by
      #@movies = Movie.order(:release_date)
      @highlight = 'release_date'
    else
      @sort_by = ""
      #@movies = Movie.all
      @highlight = nil
    @movies = Movie.with_ratings(@ratings_to_show, @sort_by)
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
