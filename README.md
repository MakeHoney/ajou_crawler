# 크롤링 삽질 리포트

루비 기반으로 학교 여러 홈페이지 각각에 대한 맞춤형 크롤러 메소드를 정의한 뒤에 통합 크롤링 모듈을 만들 생각이다.
언젠가는 내 앱에 사용할 날이 오겠.. 올까.

학식 페이지
---------

아주대학교 학식 페이지 html 문서는 정말 정말 정말 정말 조잡스럽게 되어있었다...
'그래도 Nokogiri로 크롤링하면 알아서 척척 파싱해 주겠지'라고 생각했었으나,
그러지 못했다. 사실 공백이나 개행문자는 크롤링 하는데 문제가 되지 않았을 것이다.
아마 추측이지만 아래 드래그된 부분(조식/백반)의 꺽쇠가 문제가 되지 않았나 싶다.

<img src="https://user-images.githubusercontent.com/31656287/38167157-a7719418-356b-11e8-95bf-c5a8160a9b9d.png">

실제 코드를 보면 아래와 같이 되어있다. (@#!@$!@$@!%!#%!)

<img src="https://user-images.githubusercontent.com/31656287/38167158-a8b32e72-356b-11e8-950a-1a8d966f4a8e.png">

구글링을 해보니 html에서는 특수기호(꺽쇠 등)을 표현하기 위해서는 엔터티코드로 
표현을 해야한다고 한다. 하지만 개발자가 이러한 점을 고려하지 않은 것 같다. 4시간 동안 삽질하게 해줘서 고마워요 ㅎ...
(그렇다고 매일 식단을 업데이트하는 교직원 누나가 엔터티코드를 입력할 수가, 그럴리가 없잖아...)
아무튼 각설하고, 위 상황을 예로 들면 아래와 같이 코드가 작성되도록 백..단에서 신경써줘야한다.

<img src="https://user-images.githubusercontent.com/31656287/38167159-aa4524b6-356b-11e8-97d9-3daf2168ef1e.png">

그렇지 않으면 나같은 사람이 크롤링을 할 경우... 아래와 같이 식단의 맨 앞글자가 짤리는 수가 있다...(주된 문제점은 이게 아니었지만)

<img src="https://user-images.githubusercontent.com/31656287/38167187-323177b2-356c-11e8-92f2-b9366467fc1b.png">

아무튼 해결 법은 간단했다. 아니 사실 네시간 동안 헤딩하면서 알아냈다. Nokogiri에는
여느 Prettifier와 비슷한 역할을 하는 메소드가 존재했다! .to_xhtml()이라는 메소드를 통해
인덴테이션을 정리한 뒤에 아래와 같이 새로운 변수에 저장을 하면 문자열 형태로 반환을 받는다.
그리고 이 변수에 저장된 값을 콘솔에 뿌린 뒤 문제시 되는 부분을 검사하던 중 코드에
13번에 해당하는 엔터티 코드가 삽입되어 있는 것을 발견하였다. 

<img src="https://user-images.githubusercontent.com/31656287/38167188-34355844-356c-11e8-91e6-0adc034c33cb.png">

본능적으로 저부분을 지우면 코드가 돌지 않을까 싶었고 gsub메소드를 통해서 문자열로부터 해당 엔터티코드를 싹다 지워버렸다.
Nokogiri::HTML(open(url))가 반환하는 타입은 문자열이 아니라 Nokogiri::HTML::Document
이기 때문에 새 변수에 해당 문자열을 인자로 Nokogiri::HTML()을 대입하였다.
그리고! 이 변수를 통해서 크롤링을 하니 문제 없이 크롤링이 되었다. 기뻤다. 끝.


마크다운 왜이리 어렵...


![1](https://user-images.githubusercontent.com/31656287/38167616-08166fb2-3573-11e8-9f40-e13976f20477.png)

끝
...
이 아니었다. 문제점이 있었다. 위의 해결법은 단지 미봉책이었다. 여전히 꺽쇠 안에 쓰여진 내용들은 크롤링 되지 않는 문제점이 있었다.
물론 메뉴는 문제 없이 크롤링이 되었지만, 꺽쇠 안의 내용은 주로 식당의 이름이나 가격정보였다. 이게 빠지면 의미가 없는 것 같아서
코드를 수정했다. gsub에 /<[가-힣]/ 라는 정규표현식을 이용하여 문제를 해결하였다.(*gsub이 콜백형태로 쓰일 수 있다는 것도 처음 알았다.)
< 뒤에 한글이오거나 한글 뒤에 >가 오는 것에 해당되는 꺽쇠들을 전부 엔티티 코드로 치환하였다. (사실 greater than sign (>)은 신경쓸 필요가 없긴하다.)

![2](https://user-images.githubusercontent.com/31656287/38175294-583cd02e-3615-11e8-8746-3f7036fc1703.png)

이제 좀더 보기 좋은 형태로(식당별로) 정리하는 일을 해야겠지? 아래는 긁어온 3월 30일자 메뉴다.

![1](https://user-images.githubusercontent.com/31656287/38175293-549db9b0-3615-11e8-82ca-1ee8841dd5a9.png)



2018.04.02 <br>
식당별 구획, 아침점심저녁 구분 추가

things to do : 교직원식당 구획나누기, 아침점심저녁 선택가능하도록 조치, 카카오봇에 연동해보기, 공지사항 크롤링하기(o), 
도서관 공석열람기능 추가 (http://u-campus.ajou.ac.kr/ltms/rmstatus/vew.rmstatus), 소학회, 과별공지사항 향후 고려

http://u-campus.ajou.ac.kr/ltms/rmstatus/vew.rmstatus?bd_code=JL&rm_code=undefined 에서 각 열람실 url을 아래와 같이 추출하였다.
<p>
	http://u-campus.ajou.ac.kr/ltms/rmstatus/vew.rmstatus?bd_code=JL&rm_code=JL0C1
</p>
<p>
	http://u-campus.ajou.ac.kr/ltms/rmstatus/vew.rmstatus?bd_code=JL&rm_code=JL0D1
</p>
*Nokogiri 모듈을 생성자에 넣어놓는 것은 성능을 저하시키는가?


// 해쉬테이블 구조로 
