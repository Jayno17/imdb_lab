require_relative("../db/sql_runner")

class Movie

attr_reader :id
attr_accessor :title, :genre, :budget

def initialize(options)
  @id = options["id"].to_i if options["id"]
  @title = options["title"]
  @genre = options["genre"]
  @budget = options["budget"]
end

def save()
  sql = "INSERT INTO movies
  (title, genre, budget)
  VALUES
  ($1, $2, $3)
  RETURNING id"
  values = [@title, @genre, @budget]
  movie = SqlRunner.run(sql, values)[0]
  @id = movie["id"].to_i()
end

def get_fees()
  sql = "SELECT fee FROM castings WHERE movie_id = $1"
  values = [@id]
  get_fees = SqlRunner.run(sql, values)
  fees_array = get_fees.map { |fee| fee["fee"].to_i}
  return fees_array.reduce { |sum, number| sum + number}

end

def budget()
  @budget -= get_fees()
  return @budget
end


def stars()
  sql = "SELECT stars.* FROM stars
  INNER JOIN castings ON castings.star_id = stars.id WHERE movie_id = $1"
  values = [@id]
  stars = SqlRunner.run(sql, values)
  return stars.map { |star| Star.new(star)}
end

def delete()
  sql = "DELETE FROM movies
  WHERE
  id = $1"
  value = [@id]
  SqlRunner.run(sql, value)
end

def update()
  sql = "UPDATE movies
  SET (title, genre, budget)=
  ($1, $2, $3)
  WHERE
  id = $4"
  values =[@title, @genre, @budget, @id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)

end

def self.all()
  sql = "SELECT * FROM movies"
  movies = SqlRunner.run(sql)
  return movies.map { |movie| Movie.new(movie)}
end

end
