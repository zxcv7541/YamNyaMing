<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<title>얌냐밍</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css?ver=1">
<script src="${pageContext.request.contextPath}/resources/js/member.js"></script>
</head>
<body>
<header id="member-main-header">
	<h1><a href="/index.jsp">YamNyaMing</a></h1>
	<ul>
        <li><a href="">로그인</a></li>
        <li><a href="">회원가입</a></li>
    </ul>
    <h2>맛있는 가이드, 얌냐밍</h2>
    <form action="/search.do" method="get">
    	<input type="text" name="search" value="검색할 키워드를 입력해주세요" onfocus="this.value=''">
    	<input type="submit" value="검색">
    </form>
</header>
<section id="member-main-section">
	<article>
		<h3>얌냐밍과 함께 찾는 맛집</h3>
		<p>기다리지 않는 즐거움, 얌냐밍이 진짜 맛집을 추천합니다</p>
	</article>
	<article>
		<div><a href="/search.do?search=한식">한식</a></div>
		<div><a href="/search.do?search=양식">양식</a></div>
		<div><a href="/search.do?search=일식">일식</a></div>
		<div><a href="/search.do?search=중식">중식</a></div>
	</article>
	<article>
		<div><a href="/search.do?search=카페">카페</a></div>
		<div><a href="/search.do?search=베이커리">베이커리</a></div>
	</article>
</section>
</body>
</html>