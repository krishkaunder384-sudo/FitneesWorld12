
<%@page import="com.gym_website.entities.Category"%>
<%@page import="com.gym_website.helper.ConnectionProvider"%>
<%@page import="com.gym_website.dao.PostDao"%>
<%@page import="com.gym_website.entities.Message"%>
<%@page import="com.gym_website.entities.User"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
<!--bootstrap CSS  -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/index.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	/*website:https://bennettfeely.com/clippy/  */
	clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 91%, 70% 100%, 31% 92%, 0 100%, 0%
		30%);
}
body{
	background-image: url(img/bg-image.jpg);
	background-size: cover;
	background-attachment: fixed;
	background-repeat: no-repeat;
	}
</style>
</head>
<body>
	<!--Starting of NavBar  -->
	<nav class="navbar navbar-expand-lg navbar-dark " style="background-color: #3d5afe">
		
		

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			

			 <li class="nav-item"><a class="nav-link" href="<%=application.getContextPath()%>/upload_post/do_post.jsp"
					data-toggle="modal" data-target="#add-post-modal"><span
						class="fa fa-asterisk"></span> Do Post</a></li>

		</ul>

		<ul class="navbar-nav mr-right">
	

			<li class="nav-item"><a class="nav-link"
				href="<%=application.getContextPath()%>/logoutservlet"><span
					class="fa fa-user-plus"></span> Logout</a></li>
		</ul>

		</div>
	</nav>

	<!--End of NavBar  -->
		<!--Main Body of the pages Start  -->
<%@include file="/Profile(Nav_Bar , Main_Page , Proile_Model , Post_Model)/Profile_Main_Body.jsp" %>
	<!--Main Body of the pages End   -->

	
	<!--Start Post Modal  -->

	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details..</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form id="add-post-form" action="addpostservlet" method="post" enctype="multipart/form-data">

						<div class="form-group">
						  <h1 style="text-align: center;">Fill in Your Gym Details</h1>
					 		<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>

								<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postd.getAllCategories();
								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>

								<%
								}
								%>
							</select> 
						</div>

						<%@include file="/upload_post/do_post.jsp" %>

					</form>


				</div>

			</div>
		</div>
	</div>


	<!--END add post modal-->





	<!--End Post Modal  -->








	<%@include file="/script.jsp"%>


</body>
</html>