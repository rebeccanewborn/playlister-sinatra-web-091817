class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    name.gsub(/[^ 0-9A-Za-z]/, '').downcase.tr(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find do |song|
      song.slug == slug
    end
  end
end
