<%-- 
    Document   : statewise
    Created on : May 7, 2020, 2:15:26 PM
    Author     : HP
--%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONArray.*"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>
	<title>Covid-19</title>
    <link rel="icon" href="img/virus.png">
	<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Muli&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha256-eZrrJcwDc/3uDhsdt61sL2oOBY362qM3lon1gyExkL0=" crossorigin="anonymous" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.1/jquery.waypoints.min.js" integrity="sha256-jDnOKIOq2KNsQZTcBTEnsp76FnfMEttF6AV2DF2fFNE=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Counter-Up/1.0.0/jquery.counterup.min.js" integrity="sha256-JtQPj/3xub8oapVMaIijPNoM0DHoAtgh/gwFYuN5rik=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>	<style type="text/css">

html{
	scroll-behavior: smooth;
}

*{ margin: 0;padding: 0;box-sizing: border-box; font-family: 'Muli', sans-serif; }

.row{ margin-left: 0!important; margin-right: 0!important; }

.nav_style {
	background-color: /*#D43860*/#FF2C5A!important;
}

.nav_style a {
	color: white;
}
 /* header*/
.main_header {
	height: 450px;
	width: 100%;
}

.rightside h1 {
	font-size: 3rem;
}

.corona_rot img {
	animation: gocorona 3s linear infinite;
}

@keyframes gocorona {
	0% { transform: rotate(0); }
	100% { transform: rotate(360deg); }
}

.leftside img{
	animation: heartbeat 5s linear infinite;
}


/* corona update*/

.corona_update {
	margin: 0 0 30px 0;
}

.corona_update h3 {
	color: #ff7675;
}

.corona_update h1 {
	font-size: 2rem;
	text-align: center;
}

/* abput section*/

.sub_section{
	background-color: #fbfafd;
}

/* Footer*/

.footer_style{
	background-color: #D43860!important;
}

.footer_style p,a {
	margin-bottom: 0!important;
	color: white;
}

/* Top scroll*/

#myBtn {
	display: none;/*hidden by default*/
	position: fixed;/*fixed sticky position*/
	bottom: 30px;
	right: 40px;
	z-index: 99;/*make sure it does not overlap*/
	border: none;
	outline: none;
	background-color: #00A8FF;
	color: white;
	cursor: pointer;
	padding: 10px;
	border-radius: 10px;
}

#myBtn:hover {
	background:#606060;
}

/* responsive*/

@media(max-width: 780px)
{
	.main_header{ height: 700px; text-align: center; }

	.main_header h1 {
		text-align: center;
		padding: 0;
		width: 100%;
		font-size: 34px;
	}

	.count_style {
		display: inline!important;
		}

	.count_style p {
		text-align: center;
		}

	.about_res{
		margin-left: 0!important;
	}
}

a {
   
  color: black;
  position: relative;
  text-decoration: none;
  text-transform: uppercase;
}




</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#indiacases tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>

</head>
<body onload="fetch()">

<nav class="navbar navbar-dark navbar-expand-lg nav_style p-3">
  <a class="navbar-brand pl-5" href="index.jsp">COVID-19</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav ml-auto pr-5 text-capitalize">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#aboutid">about</a>
      <li class="nav-item">
        <a class="nav-link" href="index.jsp">IndiaCoronaLive</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="timeseriesanalysis.jsp">Day wise cases</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#sympid">symptoms</a>
      </li>
      
       <li class="nav-item">
        <a class="nav-link" href="statewisetesting.jsp">State Wise Testing</a>
      </li>
      
    </ul>
    
  </div>
</nav>

    
    
<%
   //fatching data 
   

String inline = "";

			try {
				URL url = new URL("https://api.covid19india.org/state_district_wise.json");
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.connect();
				int responsecode = conn.getResponseCode();
				System.out.println("Response code is: " + responsecode);

				if (responsecode != 200)
					throw new RuntimeException("HttpResponseCode: " + responsecode);
				else {
					Scanner sc = new Scanner(url.openStream());
					while (sc.hasNext()) {
						inline += sc.nextLine();
					}
				sc.close();
				}

				JSONParser parse = new JSONParser();
				// Type caste the parsed json data in json object
				JSONObject jobj = (JSONObject) parse.parse(inline);
				Set h = jobj.keySet();
				List<String> list = new ArrayList<String>(h);
				Collections.sort(list);
				int i;
				String st=String.valueOf(request.getParameter("st")).toLowerCase();
                                if(st.equals("india")||st.equals("null"))
                                    response.sendRedirect("home.jsp");
                                
                               // out.print(st);
				for(i=0;i<list.size();i++) {
					if(st.equals(list.get(i).toLowerCase()))
					break;
				}
					
					JSONObject jobj1 = (JSONObject) jobj.get(list.get(i));
					JSONObject jobj2 = (JSONObject) jobj1.get("districtData");
					Set h1 = jobj2.keySet();
					List<String> list1 = new ArrayList<String>(h1);
					Collections.sort(list1);

     %>                 
     
    
<div class="main_header">
	<div class="row w-100 h-100">
		<div class="col-lg-5 col-md-5 col-12 order-lg-1 order-2">
			<div class="leftside w-100 h-100 d-flex justify-content-center align-items-center">
				<img src="img\giphy11.gif" width="300" height="300">
			</div>
		</div>

		<div class="col-lg-7 col-md-7 col-12 order-lg-2 order-1">
			<div class="rightside w-100 h-100 d-flex justify-content-center align-items-center">
				<h1>Let's Stay Safe & Fight Together Against Cor<span class="corona_rot"> <img src="img\corona.png" width="50" height="50"></span>na Virus.</h1>
			</div>
		</div>
	</div>
</div>
<!--live corana update worldwide---->


<section class="corona_update container-fluid" id="indiacases">
	<div class="mb-3">
        
		<h3 class="text-uppercase text-center">COVID-19 LIVE UPDATES OF <%=st.toUpperCase()%></h3>
	</div>

	<div class="table-responsive">
		<center><p>
Search for your city : 
<input id="myInput" type="text" placeholder="Entet City Name">
</p></center>
		<table class=" table table-bordered table-striped text-center" id="tbval">
			<tr style="color: #fff; background: #202020;">
				<th>City</th>
				<th>Confirmed</th>
                                <th>Active</th>
				<th>Recovered</th>
				<th>Deaths</th>
				
			</tr>
                        <tr>

				<% 
for (int j = 0; j < list1.size(); j++) {
JSONObject jobj3 = (JSONObject) jobj2.get(list1.get(j));
%>
<th><%=list1.get(j)%></th>

                                <th><%=jobj3.get("confirmed")%></th>
                                <th><%=jobj3.get("active")%></th>
                                 <th><%=jobj3.get("recovered")%></th>
                                <th><%=jobj3.get("deceased")%></th>
                                 </tr>
					<%}
                                        %>

                                
                                
				
				
                           
				
			<%
				conn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
                                %>
                                
                                
			
		</table>

	</div>
	
</section>


<!-- About Section-->

<div class="container-fluid sub_section pt-5 pb-5" id="aboutid">
	<div class="section_header text-center mb-5 mt-4">
		<h1>About COVID-19</h1>	
	</div>

	<div class="row pt-5">
		<div class="col-lg-5 col-md-6 col-12 ml-5 about_res">
			<img src="img/aboutcorona.jpg" class="img-fluid">
		</div>

		<div class="col-lg-6 col-md-6 col-12">
			<h2>What is COVID-19(Corona-Virus)</h2>
			<p>Coronavirus disease (COVID-19) is an infectious disease caused by a new virus.
				The disease causes respiratory illness (like the flu) with symptoms such as a cough, fever, and in more severe cases, difficulty breathing.<br><br>
				<strong>How it spreads</strong><br>
				Coronavirus disease spreads primarily through contact with an infected person when they cough or sneeze. It also spreads when a person touches a surface or object that has the virus on it, then touches their eyes, nose, or mouth.</p>
		</div>
	</div>
</div>

<!--- corona symptoms-->

<div class="container-fluid pt-5 pb-5" id="sympid">
	<div class="section_header text-center mb-5 mt-4">
		<h1>Coronavirus Symptoms</h1>	
	</div>

	<div class="container">
		<div class="row">
			<div class="col-lg-4 col-md-4 col-12 mt-5">
				<figure class="text-center">
					<img src="img/cough.png" class="img-fluid" width="120" height="120">
					<figcaption>Cough</figcaption>
				</figure>
			</div>

			<div class="col-lg-4 col-md-4 col-12 mt-5">
				<figure class="text-center">
					<img src="img/runnynose.png" class="img-fluid" width="120" height="120">
					<figcaption>Running Nose</figcaption>
				</figure>
			</div>

			<div class="col-lg-4 col-md-4 col-12 mt-5">
				<figure class="text-center">
					<img src="img/fever.png" class="img-fluid" width="120" height="120">
					<figcaption>Fever</figcaption>
				</figure>
			</div>

			<div class="col-lg-4 col-md-4 col-12 mt-5">
				<figure class="text-center">
					<img src="img/sick.png" class="img-fluid" width="120" height="120">
					<figcaption>Cold</figcaption>
				</figure>
			</div>

			<div class="col-lg-4 col-md-4 col-12 mt-5">
				<figure class="text-center">
					<img src="img/tired.png" class="img-fluid" width="120" height="120">
					<figcaption>Tiredness</figcaption>
				</figure>
			</div>

			<div class="col-lg-4 col-md-4 col-12 mt-5">
				<figure class="text-center">
					<img src="img/breathing.png" class="img-fluid" width="120" height="120">
					<figcaption>Difficulty in breathing(severe cases)</figcaption>
				</figure>
			</div>
		</div>
	</div>
</div>


<!----scroll top ---->

<div class="container scrolltop float-right pr-5">
	<i class="fa fa-arrow-up" onclick="topFunction()" id="myBtn"></i>
</div>

<!----Footer ---->

<footer class="mt-5">
	<div class="footer_style text-black text-center container-fluid">
            <p><b>By Anuj Khandelwal</b></p>
		

	</div>
</footer>

<script type="text/javascript">

	$('.count').counterUp({
		delay:10,
		time:3000
	})
	mybutton = document.getElementById("myBtn");

	window.onscroll = function() {scrollFunction()};
	function scrollFunction() {
		if(document.body.scrollTop >100 || document.documentElement.scrollTop > 100) {
			mybutton.style.display = "block";
		}
		else {
			mybutton.style.display = "none";
		}
	}

	function topFunction() {
		document.body.scrollTop = 0; // For safari
		document.documentElement.scrollTop = 0; //For chrome, firefox and Opera
	}




</script>

</body>
</html>



     


