require 'nokogiri'
require 'open-uri'

def scrap()
	url = "http://www.mtgtop8.com/event?e=7279&f=VI"
 
	data = Nokogiri::HTML(open(url))

	cards = data.css('.hover_tr')
 
	cards.each do |card|
    # name of the show
    #puts concert.at_css('.hover_tr').text
 
    # date of the show
    ########puts concert.at_css('.L14').text
		puts cards.at_css('.player').text
   end
  # show price or sold out
  # Remember, when a show is sold out, there is no div with the selector .price
  # What we are doing here is setting price = to that selector.  We then test
  # to see whether it is nil or not which let's us know if the show is SOLD OUT.
end
 
  # blank line to make results prettier
  puts "----------------"
 
scrap