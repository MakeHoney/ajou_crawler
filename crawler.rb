require 'http'
require 'open-uri'
require 'nokogiri'

	# f = File.open('test.txt', 'w')
	# f.puts @html #	파일 입출력을 이용하여 문서 디버깅

class SchoolFood
	@page;

	def initialize
		url = 'http://www.ajou.ac.kr/kr/life/food.jsp'
		html = fixHtml(open(url).read)
		# open(url)은 오브젝트명을 반환 open(url).read는 html문서 반환
		@page = Nokogiri::HTML(html)
	end

	def fixHtml(html)
		html.gsub!(/<[가-힣]/) {|s| s = '※ &lt;' + s[1]}
		html.gsub!(/[가-힣]>/) {|s| s = s[0] + '&gt;'}
	end
	
	def studentFoodCourt
		@page.css('table.ajou_table')[0].css('td.no_right li').each do |li|
			puts li.text
		end	
	end

	def dormFoodCourt
		time = ['아침', '점심', '저녁']

		3.times do |i|
			puts "******** #{time[i]} ********\n"
			@page.css('table.ajou_table')[1].
			css('td.no_right')[i + 1].		# 아침 점심 저녁 선택자
			css('li').each do |li|
				puts li.text
			end	
			puts "\n\n"
		end
	end

	def wholeList
		@page.css('table.ajou_table li').each do |li|
		puts li.text
		end		
	end
end

class Notice
	attr_accessor :totalNum
	@home; @notice; @page; @totalNum
	@@codeForNotice = {
		'schoolAffair' => '76',	# 학사
		'nonSubject' => '290',	# 비교과
		'scholarship' => '77',	# 장학
		'academic' => '78',		# 학술
		'admission' => '79',	# 입학
		'job' => '80',			# 취업
		'office' => '84',		# 사무
		'event' => '85',		# 행사
		'etc' => '86',			# 기타
		'paran' => '317'		# 파란학기제
	}

	# search:search_category:category=76
	# http://www.ajou.ac.kr/new/ajou/notice.jsp?mode=list
	# http://www.ajou.ac.kr/new/ajou/notice.jsp?search:search_category:category=77
	def initialize(key)
		@home = 'http://www.ajou.ac.kr'
		@notice = @home + '/new/ajou/notice.jsp'

		if(key.eql?("home"))
			url = @notice
		else
			url = @notice + "?search:search_category:category=#{@@codeForNotice[key]}"
		end
		# Ruby에서는 생성자 오버로딩을 지원하지 않는다.
		# 때문에 조건문을 통해서 처리하였다.
		@page = Nokogiri::HTML(open(url).read)
		@totalNum = numOfPost
	end

	def numOfPost
		endPageUrl = @home + @page.css('.pager_wrap a[title="끝"]')[0]['href'].to_s
		# a 태그 중에 title의 속성이 '끝'인 라인을 불러온다.
		# @page.css('div.pager_wrap a[title="끝"]')는 배열로 저장이 되기 때문에
		# [0]와 같이 인덱스를 명시해줘야 한다. ['href']는 a 태그의 href값 참조하게 해준다.
		html = open(endPageUrl)
		endPage = Nokogiri::HTML(html)

		partial1 = endPageUrl.split('offset=')[1].to_i
		partial2 = endPage.css('.list_wrap a').length
		entireNumOfPost = partial1 + partial2
		return entireNumOfPost
	end

	def printNotice(userNumOfNotice)
		newNotice = @totalNum - userNumOfNotice
		puts "총 #{newNotice}개의 새로운 공지가 있습니다."
		puts "총 게시물의 수 : #{@totalNum}"
		newNotice.times do |i|
			puts @page.css('.list_wrap a')[i].text
		end
		# puts @page.css('.list_wrap a').text
		# puts tmpNotice
	end
end

# test = SchoolFood.new()

# test.dormFoodCourt

test = Notice.new('home')
test.printNotice(6893)