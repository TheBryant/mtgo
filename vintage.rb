require 'open-uri'

def vintage(decklist='http://www.mtgtop8.com/event?e=7279&f=VI')
	prices = Hash.new
	cards = Hash.new(0)
	open("http://supernovabots.com/prices_0.txt") do |file|
		file.each_line do |line|
			r = /(^[A-z][\w\s\,\'\-]+[A-z])\s{1}\[[\w]+\]\s+([\d\.]+)\s+([\d\.]*)/.match(line)
			prices[r[1]] = [r[2], r[3]] if r
		end
	end	

	decklist = File.new("decklist.txt", "r")
	decklist.each_line do |line|
		r = /(^\d)\s([A-z\-\s\'\,]+[A-z]$)/.match(line)
		cards[r[2]] = r[1] if r
	end

	cost = 0
	missing = []

	for card in cards.keys
		subtotal = cards[card].to_f * prices[card][0].to_f if prices[card]
		subtotal = "0" if !prices[card]
		subcost = prices[card][0] if prices[card]
		subcost = "0" if !prices[card]
		puts "#{card}	#{subcost}	#{subtotal}"
		cost += subtotal if prices[card]
		missing.push(card) unless prices[card]
	end
	puts "\n Missing: #{missing}"
	puts "\n Cost: #{cost.round(2)}"
end

vintage


