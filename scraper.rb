require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  url = "https://www.premierleague.com/players"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  players = []
  players_listing = parsed_page.css('tr')
  players_listing.each do |player|
    profile = {
      name: player.css('a.playerName').text,
      country: player.css('span.playerCountry').text
    }
    players << profile
    puts "added #{profile[:name]}"
    puts ""
  end
  puts players
end

scraper