package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.LikesDAO;
import com.doogwal.coffee.dao.PostImgsDAO;
import com.doogwal.coffee.dao.PostsDAO;
import com.doogwal.coffee.dao.RepliesDAO;
import com.doogwal.coffee.dao.ReportsDAO;

@WebServlet("/ajax/deletePost.json")
public class DeletePost extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String postNoStr = req.getParameter("postNo");
		int postNo = Integer.parseInt(postNoStr);
		
		int reportsResult = ReportsDAO.deleteReport(postNo);
		
		int repliesResult = RepliesDAO.deleteReplies(postNo);
		
		int likesResult = LikesDAO.deleteLikes(postNo);
		
		int postImgsResult = PostImgsDAO.deletePostImages(postNo);
		
		
		int result = PostsDAO.deletePost(postNo);
		
		System.out.println("result : " + result);
	}
}
