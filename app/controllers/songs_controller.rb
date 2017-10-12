class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash


  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    @artist = @song.artist
    erb :'songs/edit'
  end


  post '/songs' do

    name = params[:song][:name]
    song = Song.create(name: name)

    artist = Artist.find_or_create_by(name: params[:artist][:name])
    # if params[:new_artist].empty?
    #   song.artist = Artist.find(params[:artist][:id])
    #   song.save
    # else
    #   song.artist = Artist.create(name: params[:new_artist])
    #   song.save
    # end
    song.artist = artist
    song.genre_ids = params[:genres].uniq
    song.save

    flash[:message] = "Successfully created song."
    redirect ("/songs/#{song.slug}")
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    name = params[:song][:name]
    artist = Artist.find_or_create_by(name: params[:artist][:name])
    song.update(name: name)
    song.artist = artist
    song.genre_ids = params[:genres]
    song.save

    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{song.slug}")
  end




end
