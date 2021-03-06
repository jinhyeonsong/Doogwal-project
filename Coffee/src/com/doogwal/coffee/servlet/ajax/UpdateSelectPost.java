package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.CrewPostsDAO;
import com.doogwal.coffee.dao.LikesDAO;
import com.doogwal.coffee.dao.PostImgsDAO;
import com.doogwal.coffee.dao.PostsDAO;
import com.doogwal.coffee.dao.RepliesDAO;
import com.doogwal.coffee.vo.CrewPost;
import com.doogwal.coffee.vo.PageVO;
import com.doogwal.coffee.vo.Post;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/updateSelectPost.json")
public class UpdateSelectPost extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("application/json; charset=UTF-8");
		
		String postNoStr = req.getParameter("postNo");
//		String crewNoStr = req.getParameter("crewNo");
//		String crewMemberNoStr = req.getParameter("crewMemberNo");

		int postNo = Integer.parseInt(postNoStr);
//		int crewNo = Integer.parseInt(crewNoStr);
//		int crewMemberNo = Integer.parseInt(crewMemberNoStr);
		
		Post post = PostsDAO.selectPostUpdateOne(postNo);
		
		PrintWriter out = resp.getWriter();
		
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(post);
		out.print(json);
		
		
	}
}
