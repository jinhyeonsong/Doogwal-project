package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.CrewAppsDAO;
import com.doogwal.coffee.dao.CrewMembersDAO;
import com.fasterxml.jackson.databind.ObjectMapper;

//가입 대기자를 수락하는
@WebServlet("/ajax/acceptRegularMember.json")
public class AcceptRegularMember extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//기본 세팅
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//크루 번호랑 유저 번호 받아오고
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		int userNo = Integer.parseInt(req.getParameter("userNo"));
		
		//sql 파라메터에 필요한 map
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("userNo", userNo);
		
		int result1 = CrewMembersDAO.updateRegularMember(map);
		int result2 = CrewAppsDAO.updateRegularMember(map);
		
		//return값 생성
		int result = result1*result2;
		out.print("{\"result\":\""+result+"\"}");
	}
	
}
