require 'http'
require 'open-uri'
require 'nokogiri'

def fix_url(html)
	html.gsub!(/<[가-힣]/) {|s| s = '&lt;' + s[1]}
	html = html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'}
end


f = File.open('test.txt', 'w')

html = HTTP.get('http://www.ajou.ac.kr/kr/life/food.jsp').to_s
# html.gsub!(/<[가-힣]/) {|s| s = '&lt;' + s[1]}
# f.puts html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'} --> method
html = fix_url(html)
f.puts html
page = Nokogiri::HTML(html)
page.css('table.ajou_table li').each do |li|
	puts li.text
end