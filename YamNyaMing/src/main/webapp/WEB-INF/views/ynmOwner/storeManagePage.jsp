<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<title>얌냐밍-가게 관리</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owner/owner.css?ver=4">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owner/storeTitleInfo.css?ver=1">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member/lightslider.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>	
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/owner/ownerInfo.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/owner/ownerCategory.js?ver=1"></script>
</head>
<body>
	<header id="owner-main-header">
		<h1>
			<a href="/ownerMyPage.do">YamNyaMing 관리</a>
		</h1>
		<p>
			<a href="/storeEnrollOwner.do">입점 신청하기</a>
		</p>
		<p>
			${sessionScope.owner.owName} 님 (${sessionScope.owner.owId}) <a href="/index.jsp">로그아웃</a>
		</p>
	</header>
	<nav id="owner-main-nav">
		<ul>
			<li><a href="/ownerInfo.do">정보 관리</a></li>
			<li><a href="/storeManage.do">음식점 관리</a></li>
			<li><a href="/reservationManage.do">예약 관리</a></li>
			<li><a href="/couponManage.do">쿠폰 관리</a></li>
			<li><a href="/boardOwner.do">게시판 관리</a></li>
			<li><a href="/analysisOwner.do">통계 관리</a></li>
		</ul>
	</nav>
	<section id="store-select-detail">
		<div>
			<c:if test="${storeTitleInfo!=null}">
				<c:forEach var="storeList" items="${storeTitleInfo}">
					<!-- 해당 가게의 정보를 아래에 뿌려줌 -->
					<form action="/storeInfoPage.do" method="post">
						<jsp:include page="storeTitleInfo.jsp">
							<jsp:param name="storeIndex" value="${storeList.owStoreInfoPk}"/>
						  	<jsp:param name="storeName" value="${storeList.owStoreName}"/>
						  	<jsp:param name="storeTip" value="${storeList.owStoreTip}"/>
						  	<jsp:param name="storeAbsRoute" value="${storeList.owPhotoRoute}"/>
						  	<jsp:param name="storePhoto" value="${storeList.owPhotoViewRoute}"/>
						  	<jsp:param name="storeStarPoint" value="${storeList.storeStarPoint}"/>
						  	<jsp:param name="contextRoute" value="${pageContext.request.contextPath}"/>
						</jsp:include>
						<input type="hidden" name="storeIndex" value="${storeList.owStoreInfoPk}">
						<input type="submit" value="가게 정보 확인하기">
					</form>
				</c:forEach>
			</c:if>
			<!-- 없을 때 -->
			<c:if test="${storeTitleInfo==null}">
				등록된 가게가 없습니다.
			</c:if>
			<hr style="clear:both;">
			페이징
			<c:if test="${pageNaviData!=null}">
				<div id="pagingNumber">
					<c:if test="${pageNaviData.startNavi!=1}">
						<form action="/couponManage.do" method="post">
							<input type="hidden"  name="currentPage" value="${pageNaviData.startNavi-1}"> 
							<input type="submit" class="paging-num" value="<">
						</form>
					</c:if>
					<c:forEach var="i" begin="${pageNaviData.startNavi}"
						end="${pageNaviData.endNavi}">
						<c:if test="${pageNaviData.currentPage==i}">
							<form action="/couponManage.do" method="post">
								<input type="hidden" name="currentPage" value="${i}"> 
								<input type="submit" class="paging-num-select" value="${i}">
							</form>
						</c:if>
						<c:if test="${pageNaviData.currentPage!=i}">
							<form action="/couponManage.do" method="post">
								<input type="hidden" name="currentPage" value="${i}"> 
								<input type="submit" class="paging-num" value="${i}">
							</form>
						</c:if>
					</c:forEach>
					<c:if test="${pageNaviData.endNavi!=pageNaviData.pageTotalCount}">
						<form action="/couponManage.do" method="post">
							<input type="hidden" name="currentPage"	value="${pageNaviData.endNavi+1}"> 
							<input type="submit"  class="paging-num"  value=">">
						</form>
					</c:if>
				</div>
			</c:if>
		</div>
		<hr style="clear:both;">
		가게 정보 타입
		<div>
			 <form action="/storePageTypeLoad.do" method="post">
				<!-- 현재 선택된  -->
				<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
				<input type="submit" name="storeTapType" value="정보">
				<input type="submit" name="storeTapType" value="포토">
				<input type="submit" name="storeTapType" value="리뷰">
				<input type="submit" name="storeTapType" value="메뉴">
				<input type="submit" name="storeTapType" value="지도">
			</form>
		</div>
		
		<hr style="clear:both;">
		가게 상세 정보
		
		<div class="store-info-div" style="display:block;">
			<form action="/storeInfoEdit.do" method="post">
			
				<h3>위에 정보</h3>
				
				<!-- name은 바꾸면 안됨 -->
				<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
				
				가게 이름 :<p id="owStorePId" style="display:inline;"> ${storeInfoPageData.owStoreName}</p>
				<input type="text" style="display:none;" id="owStoreNameEditBtn" name="owStoreName" value="${storeInfoPageData.owStoreName}">
				<button type="button" onclick="editShow(owStorePId,owStoreNameEditBtn);">수정버튼</button>
				<br>
				
				별점 : ${storeInfoPageData.storeStarPoint} <br>
				
				전화번호 :  <p id="owStoreTelPId" style="display:inline;">${storeInfoPageData.owStoreTel}</p>
				<input type="text" style="display:none;" id="owStoreTelEditBtn" name="owStoreTel" value="${storeInfoPageData.owStoreTel}">
				<button type="button" onclick="editShow(owStoreTelPId,owStoreTelEditBtn);">수정버튼</button>
				<br>
				
				주소 :  <p id="owStoreAddrPId" style="display:inline;">${storeInfoPageData.owStoreAddr}</p> 
				<input type="text" style="display:none;" id="owStoreAddrEditBtn" name="owStoreAddr" value="${storeInfoPageData.owStoreAddr}">
				<button type="button" onclick="editShow(owStoreAddrPId,owStoreAddrEditBtn);">수정버튼</button>
				<br>
				
				사이트 주소 : <p id="owStoreUrlPId" style="display:inline;">${storeInfoPageData.owStoreUrl}</p> 
				<input type="text" style="display:none;" id="owStoreUrlEditBtn" name="owStoreUrl" value="${storeInfoPageData.owStoreUrl}">
				<button type="button" onclick="editShow(owStoreUrlPId,owStoreUrlEditBtn);">수정버튼</button>
				<br>
				
				영업시간 :  <p id="owStoreWorkingPId" style="display:inline;">${storeInfoPageData.owStoreWorkingTime}</p>
				<input type="text" style="display:none;" id="owStoreWorkingEditBtn" name="owStoreWorkingTime" value="${storeInfoPageData.owStoreWorkingTime}">
				<button type="button" onclick="editShow(owStoreWorkingPId,owStoreWorkingEditBtn);">수정버튼</button>
				<br>
				
				예산 :   <p id="owStoreBudgetPId" style="display:inline;">${storeInfoPageData.budgetInfo}</p>
				<input type="text" style="display:none;" id="owStoreBudgetEditBtn" name="budgetInfo" value="${storeInfoPageData.budgetInfo}">
				<button type="button" onclick="editShow(owStoreBudgetPId,owStoreBudgetEditBtn);">수정버튼</button>
				<br>
				
				<h3>아래쪽 탭 정보</h3>
				
				한줄설명 : <p id="owStoreCommentPId" style="display:inline;">${storeInfoPageData.owStoreLineComment}</p>
				<input type="text" style="display:none;" id="owStoreCommentEditBtn" name="owStoreLineComment" value="${storeInfoPageData.owStoreLineComment}">
				<button type="button" onclick="editShow(owStoreCommentPId,owStoreCommentEditBtn);">수정버튼</button>
				<br>
				
				팁 :  <p id="owStoreTipPId" style="display:inline;">${storeInfoPageData.owStoreTip}</p>
				<input type="text" style="display:none;" id="owStoreTipEditBtn" name="owStoreTip" value="${storeInfoPageData.owStoreTip}">
				<button type="button" onclick="editShow(owStoreTipPId,owStoreTipEditBtn);">수정버튼</button>
				<br>
				
				음식 종류 : <p id="owStoreTypePId" style="display:inline;">${storeInfoPageData.owBigTypeFk}/${storeInfoPageData.owSmallTypeFk}</p>
					<div id="owStoreTypeEditSelect" style="display:none;">
						<select name="owBigTypeFk" id="firstSelect" onchange="changeSelect()">
							<option>대분류</option>
						</select>
						<select name="owSmallTypeFk" id="finalSelect">
							<option>소분류</option>
						</select>
					</div>
				<button type="button" onclick="editShow(owStoreTypePId,owStoreTypeEditSelect);">수정버튼</button>
				<br>
				
				추천메뉴 : <p id="owStoreRecommandPId" style="display:inline;">${storeInfoPageData.recommandMenu}</p>
				<input type="text" style="display:none;" id="owStoreRecommandEditBtn" name="recommandMenu" value="${storeInfoPageData.recommandMenu}">
				<button type="button" onclick="editShow(owStoreRecommandPId,owStoreRecommandEditBtn);">수정버튼</button>
				<br>
				
				테이블 : <p id="owStoreTablePId" style="display:inline;">${storeInfoPageData.storeTableInfo}</p>
				<input type="text" style="display:none;" id="owStoreTableEditBtn" name="storeTableInfo" value="${storeInfoPageData.owStoreLineComment}">
				<button type="button" onclick="editShow(owStoreTablePId,owStoreTableEditBtn);">수정버튼</button>
				<br>
				
				부가정보 : <p id="owStoreSubInfoPId" style="display:inline;">${storeInfoPageData.owSubInfo}</p>
				<input type="text" style="display:none;" id="owStoreSubInfoEditBtn" name="owSubInfo" value="${storeInfoPageData.owStoreLineComment}">
				<button type="button" onclick="editShow(owStoreSubInfoPId,owStoreSubInfoEditBtn);">수정버튼</button>
				<br>
				
				판매주류 : <p id="owStoreDrinkInfoPId" style="display:inline;">${storeInfoPageData.owDrinkListInfo}</p>
				<input type="text" style="display:none;" id="owStoreDrinkInfoEditBtn" name="owDrinkListInfo" value="${storeInfoPageData.owStoreLineComment}">
				<button type="button" onclick="editShow(owStoreDrinkInfoPId,owStoreDrinkInfoEditBtn);">수정버튼</button>
				<br>
				최근 예약 히스토리 : <br>		
				<input type="submit" value="가게 정보 업데이트">
			</form>
		</div>
		<div class="store-info-div" style="display:none;">
			<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
			<h3>이미지를  클릭해서 삭제 할 수 있습니다.</h3>
			<!-- <form action="/storeHeadPhotoEdit.do" method="post"> -->
			<c:if test="${headPhotoList!=null}">
				<c:forEach var="headPhoto" items="${headPhotoList}">
					<input type="hidden" id="${headPhoto.owStorePhotoPk}_route" value="${headPhoto.photoRoute}">
					<input type="hidden" id="${headPhoto.owStorePhotoPk}_name" value="${headPhoto.remakeName}">
					<input type="hidden" id="${headPhoto.owStorePhotoPk}_detailPk" value="${headPhoto.storeDetailPk}">
					<input type="hidden" id="${headPhoto.owStorePhotoPk}_headList" value="${headPhoto.headStoreList}">
					<img src="${headPhoto.owPhotoViewRoute}" id="${headPhoto.owStorePhotoPk}"
					onclick='deleteHeadPhoto(${headPhoto.owStorePhotoPk});' 
					style="width:200px; height:200px;" />
				</c:forEach>
			</c:if>
			<c:if test="${headPhotoList==null}">
				대표사진이 없습니다.
			</c:if>
			<form action="/storeHeadPhotoUpload.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
				<input type="hidden" name="storeTapType" value="정보">
				<div id="menuType">
					<input type="file" name="mainImgFile" id="mainImage" accept="${pageContext.request.contextPath}/resources/image/*" onchange="reviewFilesUpload();" multiple/>
					<label for="mainImage">이미지 추가</label>
					<div>
						<div class="imgs_wrap">
							<img id="img"/>
						</div>
					</div>
					<img id="output"/>
					<p>업체를 대표하는 이미지를 추가해주세요.</p>
				</div>
				<input type="submit" value="대표사진 등록">
			</form>
		</div>
		<div class="store-info-div" style="display:none;">
			<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
			리뷰
		</div>
		<div class="store-info-div" style="display:none;">
			<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
			메뉴
		</div>
		<div class="store-info-div" style="display:none;">
			<input type="hidden" name="storeIndex" value="${currentStoreIndex}">
			맵
		</div>
	</section>
	<script>
		window.onload=function(){
			$("#mainImage").on("change",reviewPhotoSelect);
			var storeDivArr = document.getElementsByClassName("store-info-div");
			for(var i = 0; i<storeDivArr.length;i++)
			{
				if(i==${storeTapType}){
					storeDivArr[i].style.display = "block";
				}
				else storeDivArr[i].style.display="none";
			}
		}
		function editShow(showPId,inputId)
		{
			if(inputId.style.display=="none")
			{
				showPId.style.display="none";
				inputId.style.display="inline";
			}
			else{
				showPId.style.display="inline";
				inputId.style.display = "none";
			}
		}
		
		function storeInfoTapBtn(currentTap, tapType)
		{
			var storeDivArr = document.getElementsByClassName("store-info-div");
			for(var i = 0; i<storeDivArr.length;i++)
			{
				if(currentTap==i){
					storeDivArr[i].style.display = "block";
				}
				else storeDivArr[i].style.display="none";
			}
			$('#storeInfoTapBtn').val(tapType);
		}
		function deleteHeadPhoto(photoIndex)
		{
			var route = photoIndex + "_route"
			var photoRoute = $('#'+route).val();
			
			var name = photoIndex + "_name";
			var photoRemakeName = $('#'+name).val();
			
			var detail = photoIndex + "_detailPk";
			var detailPk = $('#' + detail).val();
			
			var headList = photoIndex + "_headList";
			var headPhotoList = $('#' + headList).val();
			
			$.ajax({
				url:"/storeHeadPhotoDelete.do",
				data : {
						photoIndex:photoIndex,
						photoRoute:photoRoute,
						photoRemakeName:photoRemakeName,
						detailPk:detailPk,
						headPhotoList:headPhotoList
					   },
				type : "post",
				success : function(data){	
					if(data=="delSuccess"){
						alert("사진을 삭제했습니다.");
						$('#'+route).remove();
						$('#'+name).remove();
						$('#' + detail).remove();
						$('#' + headList).remove();
						$('#' + photoIndex).remove();
					}else{
						alert("사진 삭제에 실패했습니다.");
					}
				},
				error : function(){
					console.log("실패");	
				}
			});
			
		}

		var sel_files=[];
		var html;
		function reviewFilesUpload(){
			$("#mainImage").trigger('click');
		}

		function reviewPhotoSelect(e){
			
//			$(".imgs_wrap").empty();
			
			var files=e.target.files;
			var filesArr=Array.prototype.slice.call(files);
			
			var index=sel_files.length;
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("확장자는 이미지 확장자만 가능합니다.");
					return;
				}
				if(sel_files.length<30){
					sel_files.push(f);
					
					var reader=new FileReader();
					reader.onload=function(e){
						html="<a href=\"javascript:void(0);\"  onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img style='width:120px; height:120px;' src=\""+e.target.result+"\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
						$(".imgs_wrap").append(html);
						index++;
					}
					reader.readAsDataURL(f);
				}else
				{
					alert("대표 사진은 30개 이하만 등록할수 있습니다.");
				}
			});
		}
		
		function deleteImageAction(index){
			sel_files.splice(index,1);
			var img_id="#img_id_"+index;
			$(img_id).remove();
			
		}
	</script>
	<footer id="owner-main-footer">
		<h2>YamNyaMing</h2>
		<p>Immediately Reservation!</p>
		<address>
			㈜ 얌냠컴퍼니 대표: 김미경 | 번호: 010-9612-0530 | 이메일: minimelodi@naver.com<br>
			주소: 서울특별시 영등포구 선유동2로 57 이레빌딩 19층 KH정보교육원 | Copyright ⓒ 2018
			YamNyaMing Co. All rights reserved
		</address>
	</footer>
</body>
</html>