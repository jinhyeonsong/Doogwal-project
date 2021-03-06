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

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.FormallyCrewMemberJson;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/crewMemberList.json")
public class CrewMemberList extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//기본 세팅
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//크루 번호 받아오고
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		
		//크루 정식 인원들 받아오고
		List<FormallyCrewMemberJson> formallyCrewMembers = CrewMembersDAO.selectFormallyCrewMemberList(crewNo);
		
		//json 생성
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(formallyCrewMembers);
		out.print(json);
	}
}
