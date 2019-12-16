<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fines</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<style>
.navbar-custom {
    background-color: #e87500;
}
</style>
<script>

$( document ).ready(function() {
	sessionStorage.clear();
	var fineTable;
	var cardId;
	var fineAmount;
	$("#refresh").click(function(){
		$.ajax({
  		  url: "http://localhost:8080/LibraryManagementSystem/fines/refresh",
  		  type: "POST",
  		  success: function(result){  	     
  	  		console.log(result);
  	  	$("#refreshStatus").html(result);
		$("#refreshStatus").css('color', 'green');
		$("#refreshStatus").show();
		$("#refreshStatus").fadeOut(3000);
  	  	  },
  	  	  error: function(jqXHR, textStatus, errorThrown) {
  		 	 console.log(textStatus, errorThrown);
  		 	$("#refreshStatus").html("Something went wrong.");
    		$("#refreshStatus").css('color', 'red');
    		$("#refreshStatus").show();
    		$("#refreshStatus").fadeOut(3000);
  		  }
  		 });
		
	});
	
	$("#fSubmit").click(function(){
		
		if(($("#fcardno").val().trim() == null || $("#fcardno").val().trim() == "")){
			 $("#fSearchStatus").html("Please enter the details.");
	 		$("#fSearchStatus").css('color', 'red');
	 		$("#fSearchStatus").show();
	 		$("#fSearchStatus").fadeOut(5000); 
	 		return;
		 }
		if(fineTable != undefined){
			//fineTable.destroy();
	    	  }
		$.ajax({
  		  url: "http://localhost:8080/LibraryManagementSystem/fines/fetch",
  		  type: "POST",
  		  data : {"cardno": $("#fcardno").val().trim()},
  		  success: function(result){  	     
  	  		finesData = Array.prototype.concat.apply([], JSON.parse(result));
  	  		console.log(finesData);
  	  		$("#fcardno").val('');
  	  		if(finesData.length>0){
  	  			
  	  		$("#fSearchStatus").html("Successfully fetched the details.");
  			$("#fSearchStatus").css('color', 'green');
  			$("#fSearchStatus").show();
  			$("#fSearchStatus").fadeOut(3000);
  	  			
  	  			if(finesData[0]["payable"] === 'YES'){
	    	          $('#fPay').attr("disabled",false);
	    	          $('#fPay').attr("hidden",false);
  	  				cardId = finesData[0]["card_id"];
  	  				fineAmount = finesData[0]["amount"];
  	  			}else{
	    	          $('#fPay').attr("disabled",true);
	    	          $('#fPay').attr("hidden",false);

  	  			}
  	  		/* $("#searchStatus").html("Successfully fetched the details.");
    		$("#searchStatus").css('color', 'green');
    		$("#searchStatus").show();
    		$("#searchStatus").fadeOut(3000); */
    		
    	  $('#fineTable').show();
    	  	fineTable = $('#fineTable').DataTable({
	  	        scrollY:        '50vh',
	  	        scrollCollapse: true,
	  	        destroy : true,
				data : finesData,
				 "columns" : [
				     { "data" : "fname" },
				     { "data" : "lname" },
				     { "data" : "card_id" },
				     { "data" : "amount" },
				     { "data" : "payable" }
				 ]
    	    
	  	    	});
    	  	
    	  		
    	  	
  	  		}else{
  	    	   $("#fSearchStatus").html("No results found.");
	    		$("#fSearchStatus").css('color', 'red');
	    		$("#fSearchStatus").show();
	    		$("#fSearchStatus").fadeOut(3000);

	    		$('#fPay').attr("hidden",true);
	  	    	$('#fPay').attr("disabled",true);
	    	$('#fineTable').parents('div.dataTables_wrapper').first().hide();  
	    	$('#fineTable').hide();
	    	}
  	  	  },
  	  	  error: function(jqXHR, textStatus, errorThrown) {
  		 	 console.log(textStatus, errorThrown);
  		  }
  		 });
		
	});
	
	$("#fPay").click(function(){
		$.ajax({
	  		  url: "http://localhost:8080/LibraryManagementSystem/fines/pay",
	  		  type: "POST",
	  		  data : {"cardno": cardId,
	  			  		"fine": fineAmount},
	  		  success: function(result){
	  			console.log(result);  
	  			$("#fTableStatus").html(result);
	    		$("#fTableStatus").css('color', 'green');
	    		$("#fTableStatus").show();
	    		$("#fTableStatus").fadeOut(3000);
	    		
	    		$('#fPay').attr("hidden",true);
	  	    	$('#fPay').attr("disabled",true);
  	    		$('#fineTable').css("display","none"); 
  	    		$('#fineTable').parents('div.dataTables_wrapper').first().hide();
	  		  },
	  		  error: function(jqXHR, textStatus, errorThrown) {
	  	  		 	 console.log(textStatus, errorThrown);
	  	  		 $("#fTableStatus").html("Something went wrong.");
	     		$("#fTableStatus").css('color', 'red');
	     		$("#fTableStatus").show();
	     		$("#fTableStatus").fadeOut(3000);
	  	  		  }
	  		  });
	});
});

</script>

</head>
<body>
		<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
		  <a class="navbar-brand" href="#">Library Management System</a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse" id="navbarNavDropdown">
		    <ul class="navbar-nav">
		      <li class="nav-item">
		        <a class="nav-link" href="home">Home</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="search">Search</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="loan">Loan</a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="fine">Fines<span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="borrower">Borrowers</a>
		      </li>
		    </ul>
		  </div>
		</nav>
		<br/>
		<div class="container">
			<div class="card">
			  <div class="card-header">
			    <h5>Refresh</h5>
			  </div>
			  <div class="card-body">
			  	<h5 id="refreshStatus"></h5>
                <button type="submit" class="btn btn-primary" style="margin-top:10px" id="refresh">Click here to update fines</button>
			  </div>
			</div>
			<br/>
			<div class="card">
			  <div class="card-header">
			    <h5>Search</h5>
			  </div>
			  <div class="card-body">
			  	<h5 id="fSearchStatus"></h5>
			  	 <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">Card Number : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="fcardno" placeholder="Enter borrower card number">
				    </div>
				  </div>

				  <button type="submit" class="btn btn-primary" style="margin-top:10px" id="fSubmit">Submit</button>
			  </div>
			</div>
			<br/>
			<div class="card">
			  <div class="card-header">
			    <h5>Search Results</h5>
			  </div>
			  <div class="card-body">
			  <h5 id="fTableStatus"></h5>
			  	 <table id="fineTable" class="table table-striped table-bordered" style="width:100%;display:none">
		        	<thead>
		            <tr>
		            	<th>First Name</th>
		                <th>Last Name</th>
		                <th>Card Number</th>
		                <th>Amount</th>
		                <th>Payable</th>
		            </tr>
		        </thead>
		        <tbody>
		        </tbody>
		        </table>
		        <button type="submit" class="btn btn-primary" style="margin-top:10px" id="fPay" hidden disabled>Pay</button>
			  </div>
			</div>
		</div>
</body>
</html>