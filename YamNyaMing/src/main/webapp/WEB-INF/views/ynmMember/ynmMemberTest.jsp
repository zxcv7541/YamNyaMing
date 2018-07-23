<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery.min.js"></script>
<title>Insert title here</title>
</head>


<style>
	.img_wrap{
		width:300px;
	}
	.img_wrap img{
		max-width:100%;
	}
</style>

<script>
function idCheck(){
	var regExp;
	var resultChk;
	var memberId = $('#memberId').val();
	regExp = /^[a-z0-9]{0,12}$/;
	resultChk = regExp.test(memberId);
	if(resultChk == false){
		$('#id_check').html("<span style='color:red;'>5~12자의 영문 소문자와 숫자만 사용 가능합니다.</span>");
	}else{
		$.ajax({
 			url : "/idCheck.do",
 			data : {memberId : memberId},
 			dataType:'json',
 			success : function(data){
 				console.log(data);
 				if(data==1){
 					$('#id_check').html("<span style='color:red;'>이미 사용중이거나 탈퇴한 아이디입니다.</span>");
 				} else{
 					$('#id_check').html("<span style='color:#26a69a;'>사용할 수 있는 아이디입니다.</span>");
 				}
 		
 			}
 		});	
	}
}

function pwCheck(){
	var pwCheckBool=true;
	var regExp;
	var memberId=$('#memberId').val();
	var memberPw=$('#memberPw').val();
	
    if (memberPw == "") {
    	pwCheckBool = false;   
    	$('#pw_check').html("<span style='color:red;'>비밀번호를 입력 안했습니다.</span>"); 
        return false;
    }
    
    if (memberPw.length<6 || memberPw.length>14) {
    	pwCheckBool = false;   
    	$('#pw_check').html("<span style='color:red;'>비밀번호를 6~14자로 입력해주세요</span>"); 
        return false;
    }
    
	
		var num = memberPw.search(/[0-9]/g);
		var eng = memberPw.search(/[a-z]/ig);
	    var spe = memberPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	   

	    
		if(num < 0 || eng < 0 || spe < 0 ){

			$('#pw_check').html("<span style='color:red;'>숫자와 영문자 특수문자를 혼용해야 합니다.</span>");
			pwCheckBool=false;
			return false;

		}

		if(/(\w)\1\1\1/.test(memberPw)){

			$('#pw_check').html("<span style='color:red;'>같은문자를 3번 반복할 수 없습니다.</span>");
			pwCheckBool=false;
			return false;
		}
		
		if(memberPw.search(memberId) > -1){

			$('#pw_check').html("<span style='color:red;'>아이디를 포함 할 수 없습니다.</span>");
			pwCheckBool=false;
			return false;
		}
		
		if(pwCheckBool){
			$('#pw_check').html("<span style='color:#26a69a;'>사용 가능한 비밀번호 입니다.</span>");
		}

	
}

	function nickCheck(){
		var regExp;
		var resultChk;
		var nRegExp;
		var nResultChk;
		var memberNickName = $('#memberNickName').val();
		
		regExp = /^[가-힣|a-z|A-Z|0-9|\*]+$/
		resultChk = regExp.test(memberNickName);
		console.log(resultChk);
		
		
		if(resultChk==false){
			$('#nick_check').html("<span style='color:red;'>영어,한글,숫자만 입력가능합니다.</span>");
		}else{
			$.ajax({
	 			url : "/nickCheck.do",
	 			data : {memberNickName : memberNickName},
	 			dataType:'json',
	 			success : function(data){
	 				console.log(data);
	 				if(data==1){
	 					$('#nick_check').html("<span style='color:red;'>이미 사용중인 닉네임 입니다.</span>");
	 				} else{
	 					$('#nick_check').html("<span style='color:#26a69a;'>사용할 가능한 닉네임입니다.</span>");
	 				}
	 		
	 			}
	 		});	
		}
	}
	
	
	var sel_file;
	$(document).ready(function(){
		$("#input_avatarPhoto").on("change",avatarPhotoSelect);
	});
	
	function avatarFilesUpload(){
		$("#input_avatarPhoto").trigger('click');
	}
	
	function avatarPhotoSelect(e){
		var files=e.target.files;
		var filesArr=Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지확장자만");
				return;
			}
			sel_file=f;
			var reader=new FileReader();
			reader.onload=function(e){
				$("#img").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	
	
	
	
	var sel_files=[];
	var html;
	$(document).ready(function(){
		$("#input_reviewPhoto").on("change",reviewPhotoSelect);
	});
	
	function reviewFilesUpload(){
		$("#input_reviewPhoto").trigger('click');
	}
	
	function reviewPhotoSelect(e){
		
		var files=e.target.files;
		var filesArr=Array.prototype.slice.call(files);
		
		var index=files.length;
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			sel_files.push(f);
			
			var reader=new FileReader();
			reader.onload=function(e){
				html="<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img src=\""+e.target.result+"\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
				$(".imgs_wrap").append(html);
				index++;
			}
			reader.readAsDataURL(f);
		});
		
	}
	function deleteImageAction(index){
		sel_files.splice(index,1);
		var img_id="#img_id_"+index;
		$(img_id).remove();
		
	}

	
	
</script>

<body>
	<!-- 회원가입 -->
	<form action="/signUpMember.do" method="post" enctype="multipart/form-data">
		
		<a href="javascript:" onclick="avatarFilesUpload();">파일업로드</a>
		<input type="file"  style="display:none;" id="input_avatarPhoto" name="avatarPhoto"/>
		<div>
			<div class="img_wrap">
				<img id="img" />
			</div>
		</div>
		
		<input type="submit" value="가입">
	</form>
	
	
	
	
	<form action="/login.do" method="post">
	<input type="text" name="memberId" placeholder="아이디 입력"/>
		<input type="text" name="memberPw" placeholder="PW 입력"/>
	<input type="submit" value="로그인">
	</form>
	
	<form action="/logout.do">
		<input type="submit" value="로그아웃">
	</form>
	
	<hr>
	
	회원 탈퇴
	<form action="signOutMember.do">
		<input type="text" name="memberPw">
		<input type="submit" value="탈퇴">
		
 	</form>
 	
 	<hr>
 	
 	<form action="memberInfo.do">
 	내정보 보기
 	<input type="text" name="memberPw" value="비밀번호 입력">
 	<input type="submit" value="보기">
	</form>
	
		
		<hr>
		
	<form action="bookInsert.do">
		<input type="text" name="bookOrderCount">
		<input type="text" name="bookPartyCount">
		<input type="text" name="bookType">
		<input type="text" name="bookOption">
		<input type="text" name="bookDeposit">
		<input type="submit" value="예약">
	</form>
	
	 <form action="bookselect.do">
 	예약 정보 보기
 	<input type="submit" value="보기">
	</form>
	<hr>
		<form id="fileForm" action="/storeReviewInsert.do" enctype="multipart/form-data" method="post">
		<input type="text" id="ownerStoreEntireNo" name="ownerStoreEntireNo">
		<input type="text" id="reviewTitle" name="reviewTitle">
		<input type="text" id="reviewContent" name="reviewContent">
		<input type="text" id="reviewStar" name="reviewStar">
			
			<a href="javascript:" onclick="reviewFilesUpload();">파일업로드</a>
			<input type="file" style="display:none;" id="input_reviewPhoto" name="reviewImgList" multiple/>
		<div>
			<div class="imgs_wrap">
				<img id="img" />
			</div>
		</div>
		<input type="submit" value="댓글등록">
		</form>
		<hr>
		<form action="/reviewCheck.do">
			<input type="hidden" value="1" name="OwnerStoreEntireNo" >
			<input type="submit" value="가게 보기">
		</form>
	
</body>
</html>