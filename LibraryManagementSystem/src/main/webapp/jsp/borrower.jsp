<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Borrower</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.navbar-custom {
    background-color: #e87500;
}
</style>
<script>
$( document ).ready(function() {
	sessionStorage.clear();
	 $("#bsubmit").click(function(){
		    var ssn = $('#bSSN').val().trim();
			var fname = $('#bFName').val().trim();
			var lname = $('#bLName').val().trim();
			var email = $('#bEmail').val().trim();
			var addr = $('#bAddr').val().trim();
			var city = $('#bCity').val().trim();
			var state = $('#bState').val().trim();
			var phn = $('#bPhn').val().trim();
			
			if((ssn == "" || ssn == null) || (fname == "" || fname == null) || (lname == "" || lname == null) || (email == "" || email == null) ||
					(addr == "" || addr == null) || (city == "" || city == null) || (state == "" || state == null) || (phn == "" || phn == null)){
				$("#bStatus").html("Please enter the details.");
	    		$("#bStatus").css('color', 'red');
	    		$("#bStatus").show();
	    		$("#bStatus").fadeOut(3000);
	    		return "";
			}
			
			$.ajax({
				  url: "http://localhost:8080/LibraryManagementSystem/borrower/insert",
				  type: "POST",
				  data: {	"ssn": ssn,
					  		"fname":fname,
					  		"lname":lname,
					  		"email":email,
					  		"addr":addr,
					  		"city":city,
					  		"state":state,
					  		"phn":phn
				  		},
				  success: function(result){
					  $("#bStatus").html(result);
			    		$("#bStatus").css('color', 'green');
			    		$("#bStatus").show();
			    		$("#bStatus").fadeOut(3000);
					console.log(result);	  		
					$('#bSSN').val('');$('#bFName').val('');$('#bLName').val('');$('#bEmail').val('');$('#bAddr').val('');$('#bCity').val('');$('#bState').val('');$('#bPhn').val('');
			  	  },
			  	  error: function(jqXHR, textStatus, errorThrown) {
			  		$("#bStatus").html("Something went wrong.");
		    		$("#bStatus").css('color', 'red');
		    		$("#bStatus").show();
		    		$("#bStatus").fadeOut(3000);
				 	 console.log(textStatus, errorThrown);
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
		      <li class="nav-item">
		        <a class="nav-link" href="fine">Fines</a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="borrower">Borrowers<span class="sr-only">(current)</span></a>
		      </li>
		    </ul>
		  </div>
		</nav>
		<br/>
		<div class="container">
			<div class="card">
			  <div class="card-header">
			    <h5>New Borrower</h5>
			  </div>
			  <div class="card-body">
			  <h5 id="bStatus"></h5>
			  	 <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">SSN : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bSSN" placeholder="Enter SSN XXX-XX-XXXX">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">First Name : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bFName" placeholder="Enter first name">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">Last Name : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bLName" placeholder="Enter last name">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">Email : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bEmail" placeholder="Enter email">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">Address : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bAddr" placeholder="Enter address">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">City : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bCity" placeholder="Enter city">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">State : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bState" placeholder="Enter state">
				    </div>
				  </div>

				  <div class="form-group row">
				    <label for="" class="col-sm-2 col-form-label">Phone No : </label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="bPhn" placeholder="Enter phone number (XXX)XXX-XXXX">
				    </div>
				  </div>

				  <button type="submit" class="btn btn-primary" style="margin-top:10px" id="bsubmit">Submit</button>
			  </div>
			</div>
		</div>
</body>
</html>