<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library Management System (LMS)</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.navbar-custom {
    background-color: #e87500;
}

body {
  background: 
    linear-gradient(
      rgba(0, 0, 0, 0.5),
      rgba(0, 0, 0, 0.5)
    ),
    url(<c:url value='/assets/img/library.jpg'/>);
  background-size: cover;
  font-family: 'Source Sans Pro', sans-serif;
}

header {
  position: absolute;
  top: 40%;
  left: 30%;
  transform: translate(-50%, -50%);
  color: white;
  text-align: left;
}
h1 {
  text-transform: uppercase;
  margin: 0;
  font-size: 4rem;
  white-space: nowrap;
}

</style>
<script>
$(document).ready(function(){
	sessionStorage.clear();
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
      <li class="nav-item active">
        <a class="nav-link" href="home.html">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="search.html">Search</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="loan.html">Loan</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="fine.html">Fines</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="borrower.html">Borrowers</a>
      </li>
    </ul>
  </div>
</nav>
<header>
	<h1>Library <span style = "display: block;">Management System</span></h1>
</header>
</body>
</html>