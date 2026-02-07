package com.gym_website.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.gym_website.dao.PostDao;
import com.gym_website.entities.Post;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;
import com.gym_website.helper.Helper;


@WebServlet("/addpostservlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddPostServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("GET method is not supported for this endpoint.");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Retrieve parameters
            int cid = Integer.parseInt(request.getParameter("cid"));
            String gymName = request.getParameter("gym_name");
            String ownerName = request.getParameter("owner_name");
            String ownerEmail = request.getParameter("owner_email");
            String ownerAddress = request.getParameter("owner_address");
            String gymAbout = request.getParameter("about_gym");

            // Retrieve file parts for gym photo and owner photo
            Part gymPhotoPart = request.getPart("gymPhoto");
            String gymPhotoFileName = gymPhotoPart.getSubmittedFileName();
            Part ownerPhotoPart = request.getPart("ownerPhoto");
            String ownerPhotoFileName = ownerPhotoPart.getSubmittedFileName();

            // Get current user ID from session
          //getting currentUser id
    		HttpSession session = request.getSession();
    		User user =(User) session.getAttribute("currentUser");
    		user.getId();

            // Create Post object and save to database
            Post p = new Post(cid, gymName, gymPhotoFileName , ownerName, ownerEmail, ownerAddress, ownerPhotoFileName, gymAbout, null, cid, user.getId());
            PostDao dao = new PostDao(ConnectionProvider.getConnection());

            if(dao.savePost(p)) {
    			
    			ServletContext context = request.getServletContext();
    			String path = context.getRealPath("/") + "/post_pics/gymPhotos" + File.separator + gymPhotoPart.getSubmittedFileName();
    			String path2 = context.getRealPath("/") + "/post_pics/ownerPhotos" + File.separator + ownerPhotoPart.getSubmittedFileName();
    			System.out.println("Saving file to: " + path); // Debugging
    			System.out.println("Saving file to: " + path2); // Debugging

    			Helper.saveFile(gymPhotoPart.getInputStream(), path);
    			Helper.saveFile(ownerPhotoPart.getInputStream(), path2);
    			out.println("done");
    			
    			
    		}else {
    			out.println("error");
    		}
        } catch (Exception e) {
            e.printStackTrace(out); // Consider logging instead of printing for production
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
        } finally {
            out.close();
        }
        
    }
}
