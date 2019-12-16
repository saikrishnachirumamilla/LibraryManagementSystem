<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Book</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
	var table;
    $("#searchBtn").click(function(){
    	if($('#searchValue').val() == null || $('#searchValue').val() == ""){
    		$("#searchStatus").html("Please enter the details.");
    		$("#searchStatus").css('color', 'red');
    		$("#searchStatus").show();
    		$("#searchStatus").fadeOut(3000);
    		
    		return;
    	}
    	  $.ajax({
    		  url: "http://localhost:8080/LibraryManagementSystem/searchLMS/getBooks",
    		  type: "POST",
    		  data: {"name":$('#searchValue').val().trim()},
    		  success: function(result){
    	      var searchData = JSON.parse(result);
    	      if(searchData.length > 0){
    	    	  $("#searchStatus").html("Successfully fetched the details.");
    	    		$("#searchStatus").css('color', 'green');
    	    		$("#searchStatus").show();
    	    		$("#searchStatus").fadeOut(3000);
    	    	  $('#searchTable').show();
    	    	    table = $('#searchTable').DataTable({
      	  	        scrollY:        '30vh',
      	  	        scrollCollapse: true,
      	  	        destroy : true,
  					data : searchData,
  					 "columns" : [
  					     { "data" : "isbn10" },
  					     { "data" : "isbn13" },
  					     { "data" : "title" },
  					     { "data" : "author" },
  					     { "data" : "availability" },
  					   	 { "data" : "checkout" }
  					 ],
  			        "aoColumnDefs": [
  			           {
  			                "aTargets": [5],
  			                "mData": "isbn13",
  			                "mRender": function (data, type, full) {
  			                    return '<button href="#"' + 'id="'+ data + '">Check Out</button>';
  			                }
  			            }
  			         ]
    	    	    
      	  	    	});
    	    	    
    	    	    $('#searchTable tbody').on( 'click', 'button', function () {
    	    	        var data = table.row( $(this).parents('tr') ).data();
    	    	        sessionStorage.setItem("checkoutdata",JSON.stringify(data["isbn13"]));
    	    	        window.location.href='loan';
    	    	        console.log(data);
    	    	    });
    	    	  
    	      }else{
    	    	  $("#searchStatus").html("No results found.");
  	    		$("#searchStatus").css('color', 'red');
  	    		$("#searchStatus").show();
  	    		$("#searchStatus").fadeOut(3000);
    	    	  if(table != undefined){
    	    		  table.destroy();
    	    	  }
    	    	  $('#searchTable').hide(); 
    	      }
    	  		
    	  	  },
    	  	  error: function(jqXHR, textStatus, errorThrown) {
    	  		$("#searchStatus").html("Something went wrong.");
	    		$("#searchStatus").css('color', 'red');
	    		$("#searchStatus").show();
	    		$("#searchStatus").fadeOut(3000);
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
		      <li class="nav-item active">
		        <a class="nav-link" href="search">Search<span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="loan">Loan</a>
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
			<div class="card">
			  <div class="card-header">
			    <h5>Search Book</h5>
			  </div>
			  <div class="card-body">
			  	<h5 id="searchStatus"></h5>
			    <input type="text" class="form-control" id="searchValue" placeholder="Enter ISBN or Book Title or Author(s)" >
                <button type="submit" class="btn btn-primary" style="margin-top:10px" id="searchBtn">Search</button>
			  </div>
			</div>
			<br/>
			<div class="card">
			  <div class="card-header">
			    <h5>Search Results</h5>
			  </div>
			  <div class="card-body">
			    <table id="searchTable" class="table table-striped table-bordered" style="width:100%;display:none">
		        <thead>
		            <tr>
		            	<th>ISBN10</th>
		                <th>ISBN13</th>
		                <th>Book Title</th>
		                <th>Book Author(s)</th>
		                <th>Book Copies</th>
		                <th>Check Out</th>
		            </tr>
		        </thead>
		        <tbody>
		        </tbody>
		        </table>
			  </div>
			</div>

		</div>
</body>
</html>