<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/AdminLTE/bootstrap/css/bootstrap.min.css">

<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/AdminLTE/dist/css/AdminLTE.min.css">

<!-- jQuery 2.2.3 -->
<script src="${pageContext.request.contextPath}/resources/AdminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>

<!-- Bootstrap 3.3.6 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>

<title>환율 계산 코딩 테스트(양희철)</title>
</head>
<body>
	<div class="wrapper">
		<div class="col-md-4">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">
						환율 계산
					</h3>
				</div>
				<div class="box-body no-padding"> 
					<form>
						<table class="table no-margin font-size-12">
							<tr>
								<td class="col-md-4"><label>송금국가 :</label> </td>
								<td class="col-md-8"><label>미국(USD)</label></td>
							</tr>
							<tr>
								<td class="col-md-4"><label>수취국가 :</label> </td>
								<td class="col-md-8">
									<select id="countrySelectBox"class="form-control" onchange="getExchangeRate();">
										<option value="KRW" selected="selected">한국(KRW)</option>
										<option value="JPY">일본(JPY)</option>
										<option value="PHP">필리핀(PHP)</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="col-md-4"><label>환율 :</label> </td>
								<td class="col-md-8"><label id="exchangeRate"></label> </td>
							</tr>
							<tr>
								<td class="col-md-4"><label>송금액 :</label> </td>
								<td class="col-md-8">
									<div class="col-md-10 no-padding">
										<input class="form-control" id="amount">
									</div>
									<div class="col-md-2 no-padding">
										<label>USD</label>
									</div>
								</td>
							</tr>
							<tr>
								<td class="col-md-12" colspan="2"><button id="subBtn"type="button">Submit</button></td>
							</tr>
							<tr id="remit" style="display: none;">
								<td class="col-md-12" colspan="2"><label>수취금액은 <b id="totalExchange"></b> 입니다.</label></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var exchangeRate = "";
		$(function(){
			getExchangeRate();
			
			$("#subBtn").click(function(){
				var amount = $("#amount").val();

				if(amount == 0 || amount > 10000 || !$.isNumeric(amount)){
					alert("송금액이 바르지 않습니다.");
				}else{
					getExchangeRate();
					
					$("#remit").show();
					exchange = exchangeRate.split(" ")[0];
					var totalExchange = NumberWithoutComma(exchange)*amount;
					totalExchange = NumberWithComma(totalExchange);
					$("#totalExchange").text(totalExchange +" "+ $("#countrySelectBox").val());
				}				
			});
		});
	
		
		function getExchangeRate(){
			$.ajax({
				url: 'getExchangeRate.do',
				async: false,
				type: 'post',
				dataType: 'text',
				data: {'country' : $("#countrySelectBox").val() },
				success : function(data){
					exchangeRate = data;
					$("#exchangeRate").text(exchangeRate);
				},
		        error : function(request, status, error){
		        	alert('오류 입니다.');
		        }
			});
		}
		
		//천단위 , 빼기
		function NumberWithComma(num){
			var parts = num.toString().split(".");
			parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			parts[1] = parts[1].toString().substr(0, 2);
			return parts.join(".");
		}
		
		//천단위 ,찍기
		function NumberWithoutComma(num){
			return num.replace(/[,]/g, "");
		}

	</script>
</body>
</html>