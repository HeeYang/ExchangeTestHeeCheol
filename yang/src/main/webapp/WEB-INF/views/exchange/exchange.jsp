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

<title>ȯ�� ��� �ڵ� �׽�Ʈ(����ö)</title>
</head>
<body>
	<div class="wrapper">
		<div class="col-md-4">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">
						ȯ�� ���
					</h3>
				</div>
				<div class="box-body no-padding"> 
					<form>
						<table class="table no-margin font-size-12">
							<tr>
								<td class="col-md-4"><label>�۱ݱ��� :</label> </td>
								<td class="col-md-8"><label>�̱�(USD)</label></td>
							</tr>
							<tr>
								<td class="col-md-4"><label>���뱹�� :</label> </td>
								<td class="col-md-8">
									<select id="countrySelectBox"class="form-control" onchange="getExchangeRate();">
										<option value="KRW" selected="selected">�ѱ�(KRW)</option>
										<option value="JPY">�Ϻ�(JPY)</option>
										<option value="PHP">�ʸ���(PHP)</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="col-md-4"><label>ȯ�� :</label> </td>
								<td class="col-md-8"><label id="exchangeRate"></label> </td>
							</tr>
							<tr>
								<td class="col-md-4"><label>�۱ݾ� :</label> </td>
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
								<td class="col-md-12" colspan="2"><label>����ݾ��� <b id="totalExchange"></b> �Դϴ�.</label></td>
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
					alert("�۱ݾ��� �ٸ��� �ʽ��ϴ�.");
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
		        	alert('���� �Դϴ�.');
		        }
			});
		}
		
		//õ���� , ����
		function NumberWithComma(num){
			var parts = num.toString().split(".");
			parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			parts[1] = parts[1].toString().substr(0, 2);
			return parts.join(".");
		}
		
		//õ���� ,���
		function NumberWithoutComma(num){
			return num.replace(/[,]/g, "");
		}

	</script>
</body>
</html>