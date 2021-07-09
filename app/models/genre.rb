class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs
    
    def slug
        name = self.name.downcase
        name.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Genre.all.detect do |a|
            a.slug == slug
        end
    end
end