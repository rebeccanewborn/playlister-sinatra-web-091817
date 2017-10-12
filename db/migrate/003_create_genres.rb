class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.text :name
    end
    create_table :song_genres do |t|
      t.integer :song_id
      t.integer :genre_id
    end
  end
end
