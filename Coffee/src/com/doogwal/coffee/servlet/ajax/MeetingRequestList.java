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

import com.doogwal.coffee.dao.MeetAppsDAO;
import com.doogwal.coffee.vo.WaitingMeetingCrewsJson;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/meetingRequestList.json")
public class MeetingRequestList extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//기본 셋팅
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//크루 넘버 받아오고
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		
		//밋팅대기자들 리스트에 필요한 데이터 받아오기
		List<WaitingMeetingCrewsJson> watingMeetingCrews = MeetAppsDAO.selectWatingMeetingCrews(crewNo);
		
		//json 생성
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(watingMeetingCrews);
		out.print(json);
	}
}
