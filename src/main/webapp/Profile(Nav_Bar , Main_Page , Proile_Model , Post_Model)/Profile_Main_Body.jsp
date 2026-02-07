<%@ page import="com.gym_website.entities.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.gym_website.dao.PostDao" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
    ArrayList<Category> categories = postDao.getAllCategories();
%>

<!-- ================= MAIN BODY ================= -->
<main>
    <div class="container">
        <div class="row">

            <!-- ================= LEFT : CATEGORIES ================= -->
            <div class="col-md-4 mt-4">
                <div class="list-group">

                    <!-- ALL POSTS -->
                    <a href="#"
                       onclick="getPosts(0, this)"
                       class="c-link list-group-item list-group-item-action active">
                        All Posts
                    </a>

                    <!-- CATEGORY LIST -->
                    <%
                        if (categories != null) {
                            for (Category c : categories) {
                    %>
                        <a href="#"
                           onclick="getPosts(<%= c.getCid() %>, this)"
                           class="c-link list-group-item list-group-item-action">
                            <%= c.getName() %>
                        </a>
                    <%
                            }
                        }
                    %>

                </div>
            </div>

            <!-- ================= RIGHT : POSTS ================= -->
            <div class="col-md-8 mt-4">

                <!-- LOADER -->
                <div class="container text-center" id="loader" style="display:none;">
                    <i class="fa fa-refresh fa-4x fa-spin"></i>
                    <h3 class="mt-2">Loading...</h3>
                </div>

                <!-- POSTS CONTAINER -->
                <div class="container-fluid" id="post-container">
                    <!-- AJAX content loads here -->
                </div>

            </div>

        </div>
    </div>
</main>
<!-- ================= END MAIN BODY ================= -->
