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

import com.doogwal.coffee.dao.PostsDAO;
import com.doogwal.coffee.dao.ReportsDAO;
import com.doogwal.coffee.vo.PageVO;
import com.doogwal.coffee.vo.Post;
import com.doogwal.coffee.vo.Report;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/reportCrewMemberPost.json")
public class ReportCrewMemberPost extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int crewMemberNo = Integer.parseInt(req.getParameter("crewMemberNo"));
		
		List<Post> posts = PostsDAO.selectReportPost(crewMemberNo);
		
		for(Post p : posts) {
			int postNo = p.getNo();
			p.setReports(ReportsDAO.selectReportPost(postNo));
		}
		
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(posts);
		out.print(json);
		
	}
}
