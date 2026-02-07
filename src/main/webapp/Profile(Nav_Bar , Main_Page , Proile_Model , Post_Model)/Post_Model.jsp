<!-- /modals/add-post-modal.jsp -->

<%@ page import="java.util.ArrayList" %>
<%@ page import="com.gym_website.entities.Category" %>
<%@ page import="com.gym_website.dao.PostDao" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Create Post</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>

            <div class="modal-body">

                <form action="addpostservlet"
                      method="post"
                      enctype="multipart/form-data">

                    <div class="form-group">
                        <select class="form-control" name="cid" required>
                            <option disabled selected>Select Category</option>

                            <%
                                PostDao postd =
                                    new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list =
                                    postd.getAllCategories();

                                for (Category c : list) {
                            %>
                                <option value="<%= c.getCid() %>">
                                    <%= c.getName() %>
                                </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <input type="text"
                               name="pTitle"
                               class="form-control"
                               placeholder="Post title"
                               required>
                    </div>

                    <div class="form-group">
                        <textarea name="pContent"
                                  class="form-control"
                                  rows="4"
                                  placeholder="Post content"
                                  required></textarea>
                    </div>

                    <div class="form-group">
                        <input type="file" name="pic" class="form-control">
                    </div>

                    <button class="btn btn-primary btn-block">
                        Publish Post
                    </button>

                </form>

            </div>
        </div>
    </div>
</div>
