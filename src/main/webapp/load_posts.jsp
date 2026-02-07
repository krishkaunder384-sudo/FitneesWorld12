



<%@page import="com.gym_website.dao.LikeDao"%>
<%@page import="com.gym_website.entities.User"%>
<%@page import="com.gym_website.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.gym_website.helper.ConnectionProvider"%>
<%@page import="com.gym_website.dao.PostDao"%>
<style>
.card {
    background: rgba(20,20,20,0.95);
    border-radius: 18px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.6);
    overflow: hidden;
    transition: transform 0.35s ease, box-shadow 0.35s ease;
    color: #e5e7eb;
}

.card:hover {
    transform: translateY(-10px);
    box-shadow: 0 30px 60px rgba(0,0,0,0.8);
}

.card img {
    width: 100%;
    height: 280px;
    object-fit: cover;
    border-bottom: 4px solid #ff2e2e;
    transition: transform 0.4s ease;
}

.card:hover img {
    transform: scale(1.05);
}

.card-body h2 {
    text-align: center;
    color: #ffffff;
    font-weight: 700;
}

.card-body p {
    color: #bbbbbb;
}

/* SOCIAL ICONS */
.social_icons {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 15px;
}

.social_icons i {
    font-size: 1.4rem;
    color: #aaaaaa;
    transition: color 0.3s ease, transform 0.3s ease;
}

.social_icons i:hover {
    color: #ff2e2e;
    transform: translateY(-4px);
}

/* FOOTER */
.card-footer {
    background: rgba(15,15,15,0.95);
    border-top: 1px solid #222;
}
</style>

<div class="row">
	<%
	/* User uuu=(User) session.getAttribute("currentUser"); */
	User uuu = (User) session.getAttribute("currentUser");
	if (uuu == null) {
		// Redirect to login if user is not logged in
		response.sendRedirect("login_page.jsp");
		return;
	}
	/* 	Thread.sleep(1000); //1 sec takes to load pages */

	PostDao d = new PostDao(ConnectionProvider.getConnection());
	int cid = Integer.parseInt(request.getParameter("cid"));
	List<Post> posts = null;
	if (cid == 0) {
		posts = d.getAllPosts();

	} else {
		posts = d.getPostByCatId(cid);
	}

	if (posts.size() == 0) {
		out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
		return;
	}

	for (Post p : posts) {
	%>


	<div class="col-md-6 mt-2">

		<div class="card">
			<img class="card-img-top"
				src="<%=application.getContextPath()%>/post_pics/gymPhotos/<%=p.getGym_photo()%>"
				alt="Card image cap">

			<div class="card-body">
				<h2 style="text-align: center;"><%=p.getGym_name()%></h2>
				<p><%=p.getAbout_gym()%></p>
				<div class="social_icons">
                    <i class="fa fa-twitter"></i>
                    <i class="fa fa-facebook"></i>
                    <i class="fa fa-instagram"></i>
                </div>

				<p style="text-align: right; font-size: small; color: gray;"><%=p.getpDate()%></p>
			</div>

			<div class="card-footer primary-background text-center">
				<%
				LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
				%>
				<a href="#!" onclick="doLike(<%=p.getPid()%>, <%=uuu.getId()%>)"
					class="btn btn-outline-light btn-sm"><i
					class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikeonPost(p.getPid())%></span></a>
				<a href="show_blog_page.jsp?post_id=<%=p.getPid()%>"
					class="btn btn-outline-light btn-sm">Read More...</a> <a href="#"
					class="btn btn-outline-light btn-sm"><i
					class="fa fa-commenting-o"></i> <span>20</span></a>
			</div>

		</div>

	</div>



	<%
	}
	%>
</div>