class Genre < ApplicationRecord

  has_many :products
  #enum genre: { "ケーキ": 0, "プリン": 1, "焼き菓子": 2, "キャンディ": 3 }
  #<%= f.select :genre_id, Genre.genres.keys, class: "genre" %>

end
