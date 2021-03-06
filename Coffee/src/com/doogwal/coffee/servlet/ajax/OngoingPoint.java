package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.vo.Crew;
import com.fasterxml.jackson.databind.ObjectMapper;

//밋팅데려오기에서 현재 선택한 밋팅 주최 크루의 포인트 받아오는
@WebServlet("/ajax/ongoingPoint.json")
public class OngoingPoint extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//기본 세팅
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//크루 번호 받아오고
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		
		//크루 정보 받아와서 포인트만 쓴다.
		Crew crew = CrewsDAO.selectCrewAllInformation(crewNo);
		int point = crew.getPoint();
		
		//json 생성
		out.print("{\"point\":\""+point+"\"}");
	}
}
