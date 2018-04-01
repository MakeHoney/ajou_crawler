require 'http'
require 'open-uri'
require 'nokogiri'

def fix_url(html)
	html.gsub!(/<[가-힣]/) {|s| s = '&lt;' + s[1]}
	html = html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'}
end


f = File.open('test.txt', 'w')

html = HTTP.get('http://www.ajou.ac.kr/kr/life/food.jsp?date=2018-03-30').to_s
# html.gsub!(/<[가-힣]/) {|s| s = '&lt;' + s[1]}
# f.puts html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'} --> method
html = fix_url(html)
page2 = Nokogiri::HTML(html)
page2.css('table.ajou_table li').each do |li|
	puts li.text
end