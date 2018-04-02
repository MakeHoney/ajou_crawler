require 'http'
require 'open-uri'
require 'nokogiri'

	# f = File.open('test.txt', 'w')
	# f.puts @html #	파일 입출력을 이용하여 문서 디버깅

class SchoolFood
	@html; @page

	def initialize
		@html = HTTP.get('http://www.ajou.ac.kr/kr/life/food.jsp').to_s
		@html = fixHtml(@html)
		@page = Nokogiri::HTML(@html)
	end

	def fixHtml(html)
		html.gsub!('no_right left_pd', 'no_right_left_pd')	
		# html 문서 내의 class 명에 띄어쓰기를 써놓는 기염을 토해놓으신 개발자분...덕에 위 코드 한 줄이 추가되었다.
		html.gsub!(/<[가-힣]/) {|s| s = '※ &lt;' + s[1]}
		html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'}
	end
	
	def studentFoodCourt
		@page.css('table.ajou_table')[0].css('td.no_right_left_pd li').each do |li|
			puts li.text
		end	
	end

	def dormFoodCourt
		time = ['아침', '점심', '저녁']

		3.times do |i|
			puts "******** #{time[i]} ********\n"
			@page.css('table.ajou_table')[1].
			css('td.no_right_left_pd')[i].		# 아침 점심 저녁 선택자
			css('li').each do |li|
				puts li.text
			end	
			puts "\n\n"
		end
	end

	def wholeList
		page.css('table.ajou_table li').each do |li|
		puts li.text
		end		
	end

end

test = SchoolFood.new()

test.studentFoodCourt