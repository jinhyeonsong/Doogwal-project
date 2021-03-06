package com.doogwal.coffee.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.CrewMembersDAO;

@WebServlet("/transformRankToOperator.doo")
public class TransformRankToOperator extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//기본 셋팅
		HttpSession session = req.getSession();
		
		//크로멤버 번호 받아오고
		int crewMemberNo = Integer.parseInt(req.getParameter("crewMemberNo"));
		
		int result = CrewMembersDAO.transformRankToOperator(crewMemberNo);
	}
}
