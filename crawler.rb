require 'http'
require 'open-uri'
require 'nokogiri'

	# f = File.open('test.txt', 'w')
	# f.puts @html #	파일 입출력을 이용하여 문서 디버깅

class SchoolFood
	@html; @page

	def initialize
		@html = HTTP.get('http://www.ajou.ac.kr/kr/life/food.jsp').to_s
		@html = fixUrl(@html)
		@page = Nokogiri::HTML(@html)
	end

	def fixUrl(html)
		html.gsub!('no_right left_pd', 'no_right_left_pd')
		html.gsub!(/<[가-힣]/) {|s| s = '&lt;' + s[1]}
		html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'}
	end
	
	def studentFoodCourt
		@page.css('table.ajou_table')[0].css('td.no_right_left_pd li').each do |li|
		puts li.text
		end	
	end

	def schoolFood
		@page.css('table.ajou_table td.no_right_left_pd li').each do |td|
			puts td.text
		end
	end

	def wholeList
		page.css('table.ajou_table li').each do |li|
		puts li.text
		end		
	end

end

test = SchoolFood.new()

test.arrangeList