class Song < ActiveRecord::Base
    has_many :song_genres
    has_many :genres, through: :song_genres
    belongs_to :artist

    def slug
        name = self.name.downcase
        name.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Song.all.detect do |a|
            a.slug == slug
        end
    end
end