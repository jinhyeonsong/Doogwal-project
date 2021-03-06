package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.RepliesDAO;
import com.doogwal.coffee.vo.Reply;
import com.doogwal.coffee.vo.UserMember;
import com.fasterxml.jackson.databind.ObjectMapper;


@WebServlet("/ajax/insertReply.json")
public class WriteReply extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		resp.setContentType("application/json; charset=UTF-8");

		PrintWriter out = resp.getWriter();
		
		String postNoStr = req.getParameter("postNo");
		String memberNoStr = req.getParameter("memberNo");
		String reply = req.getParameter("reply");
		
		int postNo = Integer.parseInt(postNoStr);
		int memberNo = Integer.parseInt(memberNoStr);
		
		Reply r = new Reply(postNo, memberNo, reply);
		
		int result = RepliesDAO.insertReply(r);
			
		UserMember userMemeber = new UserMember();
		
		userMemeber = CrewMembersDAO.selectCrewMemberOneByNo(memberNo);
		
		System.out.println("reply 결과: " + result);
		
		r.setName(userMemeber.getName());
		r.setProfileImg(userMemeber.getProfileImg());
		
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(r);
		out.print(json);
		
		
	}
}
