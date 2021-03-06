package com.doogwal.coffee.servlet.ajax;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.dao.SchedulesDAO;

import com.doogwal.coffee.vo.Meeting;
import com.fasterxml.jackson.databind.ObjectMapper;



@WebServlet("/ajax/bringMeetingsByDateRange.json")
public class BringMeetingsByDateRange extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		System.out.println("여기로옴!");
		
		
		String dateRange = req.getParameter("dateRange");
		System.out.println(dateRange);
		
		String startFrom = dateRange.substring(0, 10);
		System.out.println(startFrom);
		String endHere = dateRange.substring(13);
		System.out.println(endHere);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("startFrom", startFrom);
		map.put("endHere", endHere);
		//형변환
		
		
		List<Meeting> meetingsByDateRange = SchedulesDAO.selectMeetingListByDateRange(map);
		System.out.println(meetingsByDateRange);
		//int crewNo = 0;
		//String crewName = null;
		
		
//		for(Meeting meetingBytheme:meetingsBytheme) {
//			System.out.println("여기까지 옴!");
//			crewNo = meetingBytheme.getCrewNo();
//			crewName = CrewsDAO.selectNameByCrewNo(crewNo);
//			meetingBytheme.setCrewName(crewName);
//		}
		
		System.out.println("여기까지도 옴!");
		
		//ObjectMapper 객체
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(meetingsByDateRange);
		
		out.println(json);
		System.out.println(json);
		System.out.println("됐다!");
		
		
		
		
	}//doGet() end

}//BringMeetingListByThemeNo end 

