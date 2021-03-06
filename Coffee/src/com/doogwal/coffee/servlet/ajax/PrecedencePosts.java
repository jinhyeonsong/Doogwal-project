package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.PostsDAO;
import com.doogwal.coffee.vo.Post;
import com.fasterxml.jackson.databind.ObjectMapper;

//상위 고정 게시글들 정보를 담아놓는 json 생성
@WebServlet(value="/ajax/precedencePosts.json")
public class PrecedencePosts extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//기본 셋팅
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//게시판 번호 받아오고
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		
		//그 게시판 상위 고정글들 받아온다.
		List<Post> precedencePosts = PostsDAO.selectTopContents(boardNum);
				
		//json 생성
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(precedencePosts);
		out.print(json); 
	}
}
