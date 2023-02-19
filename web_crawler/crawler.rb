require 'mechanize'
require 'csv'

class Movie < Struct.new(:title, :year, :rating, :score); end

movies = []

agent = Mechanize.new
agent.user_agent_alias = "Windows Firefox"

list_page = agent.get('https://www.imdb.com/').link_with(:text => "Top 250 Movies").click
rows = list_page.root.css(".lister-list tr")

rows.take(10).each do |row|
    title = row.at_css(".titleColumn a").text.strip
    rating = row.at_css(".ratingColumn strong").text.strip

    movie_page = list_page.link_with(:text => title).click

    year = movie_page.root.css(".ipc-inline-list__item .sc-f26752fb-2").text[0, 4]
    score = "#{movie_page.root.css(".score-meta").text.strip}/100"

    movie = Movie.new(title, year, rating, score)
    movies << movie
end

CSV.open("top10movies.csv", "w", col_sep: ";") do |csv|
    csv << ["Title", "Year", "Rating", "Score"]
    movies.each do |movie|
        csv << [movie.title, movie.year, movie.rating, movie.score]
    end
end
