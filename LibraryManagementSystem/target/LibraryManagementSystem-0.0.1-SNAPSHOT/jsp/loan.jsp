<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loan</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>




<style>
.navbar-custom {
    background-color: #e87500;
}
</style>
<script>
$( document ).ready(function() {
	
	var checkInTable;
	
	if(sessionStorage.getItem("checkoutdata") != undefined){
		$('#coisbn').val(JSON.parse(sessionStorage.getItem("checkoutdata")));
	}
	 
	
	 $("#checkout").click(function(){
		 var coisbn = $('#coisbn').val().trim();
		 var cardnum = $('#cocardnum').val().trim();
	 
		 console.log("reached here");
	 if(coisbn == null || coisbn == "" || cardnum == null || cardnum == ""){
		$("#checkoutStatus").html("Please enter the details.");
 		$("#checkoutStatus").css('color', 'red');
 		$("#checkoutStatus").show();
 		$("#checkoutStatus").fadeOut(5000);
 		return;
 	}
	 
	   $.ajax({
		  url: "http://localhost:8080/LibraryManagementSystem/checkout/book",
		  type: "POST",
		  data: {"isbn"  : coisbn,
			  	 "cardno" :	cardnum},
		  success: function(result){
			  $("#checkoutStatus").html(result);
		 		$("#checkoutStatus").css('color', 'green');
		 		$("#checkoutStatus").show();
		 		$("#checkoutStatus").fadeOut(5000);
		 		$('#coisbn').val('');$('#cocardnum').val('');
	  		console.log(result);
	  	  },
	  	  error: function(jqXHR, textStatus, errorThrown) {
	  		$("#checkoutStatus").html("Something went wrong.");
	 		$("#checkoutStatus").css('color', 'red');
	 		$("#checkoutStatus").show();
	 		$("#checkoutStatus").fadeOut(5000);
		 	 console.log(textStatus, errorThrown);
		  }
		 }); 
	 });
	 
	 $("#checkin").click(function(){
		 
		 var isbn = $('#cinisbn').val().trim();
		 var cardnum = $('#cincardnum').val().trim();
		 var bname = $('#cinbname').val().trim();
		 
		 
		 if((isbn == null || isbn == "") && (cardnum == null || cardnum == "") && (bname == null || bname == "")){
			 $("#checkinStatus").html("Please enter the details.");
	 		$("#checkinStatus").css('color', 'red');
	 		$("#checkinStatus").show();
	 		$("#checkinStatus").fadeOut(5000); 
	 		return;
		 }
		 
		 if(checkInTable != undefined){
	    		//checkInTable.destroy();
	    	  }
	 
		 if(isbn == null || isbn == ""){
			 isbn ='null';
		 }
		 if(cardnum == null || cardnum == ""){
			 cardnum ='null';
		 }
		 if(bname == null || bname == ""){
			 bname ='null';
		 }
	 
	   $.ajax({
		  url: "http://localhost:8080/LibraryManagementSystem/checkin/list",
		  type: "POST",
		  data: {"isbn"  : isbn,
			  	 "cardno" :	cardnum,
			  	 "bname" : bname},
		  success: function(result){
	  		var checkInData = JSON.parse(result);
	  		
	  		if(checkInData.length > 0){
	  			$("#checkinStatus").html("Successfully fetched the details.");
    			$("#checkinStatus").css('color', 'green');
    			$("#checkinStatus").show();
    			$("#checkinStatus").fadeOut(3000);
    			$('#cinisbn').val('');$('#cincardnum').val('');$('#cinbname').val('');
  	    	  $('#checkInTable').show();
  	    		checkInTable = $('#checkInTable').DataTable({
    	  	        scrollY:        '50vh',
    	  	        scrollCollapse: true,
    	  	        destroy : true,
					data : checkInData,
					 "columns" : [
					     { "data" : "fname" },
					     { "data" : "lname" },
					     { "data" : "card_id" },
					     { "data" : "isbn13" },
					     { "data" : "loan_id" },
					   	 { "data" : "due_date" }
					 ]
  	    	    
    	  	    	});
  					
  	    		
  	    		$('#cinfinal').attr("hidden",false);
  	    		checkInTable.rows().invalidate().draw()

  	    	  
  	    		$("#checkInTable tbody tr").click(function() {
  	    			//$(this).toggleClass('selected');
  	    			
  	    			 if ( $(this).hasClass('selected') ) {
  	    	            $(this).removeClass('selected');
    	    	          $('#cinfinal').attr("disabled",true);

  	    	        }
  	    	        else {
  	    	        	checkInTable.$('tr.selected').removeClass('selected');
  	    	            $(this).addClass('selected');
  	    	          $('#cinfinal').attr("disabled",false);
  	    	        }
  	    		});
  	    	
  	    	  $("#cinfinal").unbind('click').click(function(){
  	    		  
  	    		 var selectedData = checkInTable.rows('.selected').data();
  	    		 console.log(selectedData);
  	    	 	 sessionStorage.setItem("checkInData",JSON.stringify(selectedData));
  	    	 	 
  	    	 	$.ajax({
  	    		  url: "http://localhost:8080/LibraryManagementSystem/checkin/book",
  	    		  type: "POST",
  	    		  data: {   "isbn13" : JSON.parse(sessionStorage.getItem('checkInData'))[0]["isbn13"],
  	    			  		"cardno" : String(JSON.parse(sessionStorage.getItem('checkInData'))[0]["card_id"])},
  	    		  success: function(result){
  	    			$("#checkinrStatus").html(result);
    	    		$("#checkinrStatus").css('color', 'green');
    	    		$("#checkinrStatus").show();
    	    		$("#checkinrStatus").fadeOut(3000);
    	    		
    	    		
    	  	    	  
    	  	    	
      	    		$('#cinfinal').attr("hidden",true);
    	  	    	$('#cinfinal').attr("disabled",true);
      	    		$('#checkInTable').css("display","none"); 
      	    		$('#checkInTable').parents('div.dataTables_wrapper').first().hide();
    	    		
    	    		
  	    		  },
  	    		  error: function(jqXHR, textStatus, errorThrown) {
  	   		 	 	console.log(textStatus, errorThrown);
  	   		 		$("#checkinrStatus").html("Something went wrong.");
	    			$("#checkinrStatus").css('color', 'red');
	    			$("#checkinrStatus").show();
	    			$("#checkinrStatus").fadeOut(3000);
  	  		  }
  	  		 }); 
  	    	 	 
  	    	 	 
  	    	 	 
  	    	 	 
  	    	  });
  	      }else{
  	    	$("#checkinStatus").html("No results found.");
			$("#checkinStatus").css('color', 'red');
			$("#checkinStatus").show();
			$("#checkinStatus").fadeOut(3000);
  	    	  if(checkInTable != undefined){
  	    		//checkInTable.destroy();
  	    	  }
  	    	$('#cinfinal').attr("hidden",true);
  	    	$('#cinfinal').attr("disabled",true);
	    	$('#checkInTable').css("display","none"); 
	    	$('#checkInTable').parents('div.dataTables_wrapper').first().hide(); 
  	      }
	  		
	  	  },
	  	  error: function(jqXHR, textStatus, errorThrown) {
		 	 console.log(textStatus, errorThrown);
		 	$("#checkinStatus").html("Something went wrong.");
			$("#checkinStatus").css('color', 'red');
			$("#checkinStatus").show();
			$("#checkinStatus").fadeOut(3000);
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
		      <li class="nav-item active">
		        <a class="nav-link" href="loan">Loan<span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="fine">Fines</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="borrower">Borrowers</a>
		      </li>
		    </ul>
		  </div>
		</nav>
		<br/>
		<div class="container">
		
		<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="checkout-tab" data-toggle="tab" href="#checkouttab" role="tab" aria-controls="checkout" aria-selected="true">Check Out</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="checkin-tab" data-toggle="tab" href="#checkintab" role="tab" aria-controls="checkin" aria-selected="false">Check In</a>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="checkouttab" role="tabpanel" aria-labelledby="checkout-tab">
  <br/>
  <div class="card">
			  <div class="card-header">
			    <h5>Book CheckOut</h5>
			  </div>
			  <div class="card-body">
			  <h5 id="checkoutStatus"></h5>
			    	<div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">ISBN13 : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="coisbn" placeholder="Enter ISBN13">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">Card Number : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="cocardnum" placeholder="Enter borrower card number">
				    </div>
				  </div>
				  
                <button type="submit" class="btn btn-primary" style="margin-top:10px" id="checkout">Check Out</button>
			  </div>
			</div>
  
  </div>
  <div class="tab-pane fade" id="checkintab" role="tabpanel" aria-labelledby="checkin-tab">
  <br/>
	  <div class="card">
				  <div class="card-header">
				    <h5>Book CheckIn</h5>
				  </div>
				  <div class="card-body">
				  <h5 id="checkinStatus"></h5>
					  <div class="form-group row">
					    <label for="" class="col-sm-2 col-form-label">ISBN13 : </label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="cinisbn" placeholder="Enter ISBN13">
					    </div>
					  </div>
	
					  <div class="form-group row">
					    <label for="" class="col-sm-2 col-form-label">Card Number : </label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="cincardnum" placeholder="Enter borrower card number">
					    </div>
					  </div>
	
					  <div class="form-group row">
					    <label for="" class="col-sm-2 col-form-label">Borrower Name : </label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="cinbname" placeholder="Enter borrower name">
					    </div>
					  </div>
	
	                <button type="submit" class="btn btn-primary" style="margin-top:10px" id="checkin">Submit</button>
				  </div>
				</div>
				<br/>
				<div class="card">
				  <div class="card-header">
				    <h5>Search Results</h5>
				  </div>
				  <div class="card-body">
				  <h5 id="checkinrStatus"></h5>
				  <table id="checkInTable" class="table table-striped table-bordered" style="width:100%;display:none">
			        <thead>
			            <tr>
			            	<th>First Name</th>
			                <th>Last Name</th>
			                <th>Card No</th>
			                <th>ISBN13</th>
			                <th>Loan No</th>
			                <th>Due Date</th>
			            </tr>
			        </thead>
			        <tbody>
			        </tbody>
			        </table>
			         <button type="submit" class="btn btn-primary" style="margin-top:10px" id="cinfinal" hidden disabled>Check In</button>
				  </div>
				</div>
  
  			</div>
</div>
</body>
</html>