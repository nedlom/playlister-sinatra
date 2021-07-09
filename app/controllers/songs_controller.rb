class SongsController < ApplicationController

    get '/songs' do 
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do 
        @genres = Genre.all
        erb :'/songs/new'
    end

    post '/songs' do 
    
        @artist = Artist.find_by_name(params[:artist][:name])
        
        if @artist.nil?
            @artist = Artist.new(params[:artist])
        end

        @song = Song.new(params[:song])
        @song.artist = @artist
        @song.save
    
        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        if !params[:'Artist Name'].empty?
            @song.artist = Artist.find_or_create_by(name: params[:'Artist Name'])
        end
        @song.genre_ids = params[:genres]
        @song.save
        redirect "/songs/#{@song.slug}"
    end

end