require_relative("models/star")
require_relative("models/movie")
require_relative("models/casting")

require("pry-byebug")

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({
  "first_name" => "Harrison",
  "last_name" => "Ford"
  })
star1.save()

star2 = Star.new({
  "first_name" => "Mark",
  "last_name" => "Hamill"
  })
star2.save()

  star3 = Star.new({
    "first_name" => "Carrie",
    "last_name" => "Fisher"
    })
star3.save()

movie1 = Movie.new({
  "title" => "Star Wars",
  "genre" => "sci-fi"
  })
movie1.save()

movie2 = Movie.new({
  "title" => "Indiana Jones",
  "genre" => "adventure"
  })
movie2.save()

casting1 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star1.id,
  "fee" => 100
  })
casting1.save()

casting2 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star2.id,
  "fee" => 100
  })
casting2.save()

casting3 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star3.id,
  "fee" => 100
  })
casting3.save()

casting4 = Casting.new({
  "movie_id" => movie2.id,
  "star_id" => star1.id,
  "fee" => 150
  })
casting4.save()

binding.pry
nil
