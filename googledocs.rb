require 'open-uri'
require 'nokogiri'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def gdocs(uri='https://docs.google.com/spreadsheets/d/1YsO5FNi8_jcajFjiYuFJrmElT6lxDzDVhXS-FXyajF0/pubhtml')
	doc = Nokogiri::HTML(open(uri))
	File.open("cardlist.txt", "w") { |f|
		doc.css('div table tbody tr td.s2').each do |ele|
			f.write("#{ele.text}\n")
		end
	}
end


def nova(link="http://supernovabots.com/prices_0.txt")
	prices = Hash.new
	cards = Hash.new(0)
	open(link) do |file|
		file.each_line do |line|
			r = /(^[A-z][\w\s\,\'\-\,]+[A-z])\s{1}\[[\w]+\]\s+([\d\.]+)\s+([\d\.]*)/.match(line)
			prices[r[1]] = [r[2], r[3]] if r
		end
	end	

	decklist = File.new("cardlist.txt", "r")
	decklist.each_line do |line|
		r = /(^[A-z\-\s\'\,]+[A-z]$)/.match(line)
		cards[r[1]] = 1 if r
	end

	cost = 0
	missing = []
	File.open("results.txt", "w") { |f|
		for card in cards.keys
			subcost = prices[card][0] if prices[card]
			subcost = "0" if !prices[card]
			f.write("#{card}	#{subcost}\n")
			missing.push(card) unless prices[card]
		end
	}
end

gdocs
nova