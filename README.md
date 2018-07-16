# 아주대학교 크롤러 모듈

> Language : `Ruby`
>
> Dependencies : `Nokogiri`, `open-uri`

<br />

### Description

------

~~~
아주대학교 교내 식당의 식단 정보와 공지사항 관련 정보, 도서관 여석 정보를 크롤링하는 크롤러 모듈입니다.
향후 학교 주변 교통 정보도 크롤링하는 메소드를 정의할 계획입니다.
~~~

<br />

### Class

------

- #### SchoolFood

  - ***fixHtml(html)***

  - ***partition(string)***

  - ***studentFoodCourt***

    학생 식당의 식단을 크롤링하는 메소드

  - ***dormFoodCourt***

    기숙사 식당의 식단을 크롤링하는 메소드

  - ***facultyFoodCourt***

    교직원 식당의 식단을 크롤링하는 메소드

<br />

- #### Notice

  - ***numOfPost***
  - ***printNotice***

<br />

- #### Vacancy

  - ***printVacancy***
  
  

