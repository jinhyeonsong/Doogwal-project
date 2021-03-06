package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.PostImgsDAO;
import com.doogwal.coffee.vo.PostImg;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/postImage.json")
public class PostImage extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		int postNo = Integer.parseInt(req.getParameter("postNo"));
		
		List<PostImg> postImages = PostImgsDAO.selectImageList(postNo);
		
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(postImages);
		out.print(json);
	
	}
}
