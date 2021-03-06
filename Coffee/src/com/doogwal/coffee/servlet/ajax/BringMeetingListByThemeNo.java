package com.doogwal.coffee.servlet.ajax;


import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.dao.SchedulesDAO;

import com.doogwal.coffee.vo.Meeting;
import com.fasterxml.jackson.databind.ObjectMapper;



@WebServlet("/ajax/bringMeetingListByThemeNo.json")
public class BringMeetingListByThemeNo extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		System.out.println("여기로옴!");
		
		
		String themeNoStr = req.getParameter("themeNo");
		System.out.println(themeNoStr);
		//형변환
		int themeNo = Integer.parseInt(themeNoStr);
		System.out.println("themeNO: "+themeNo);
		
		List<Meeting> meetingsBytheme = SchedulesDAO.selectMeetingListByThemeNo(themeNo);
		System.out.println(meetingsBytheme);
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
		
		String json = om.writeValueAsString(meetingsBytheme);
		
		out.println(json);
		System.out.println(json);
		System.out.println("됐다!");
		
		
		
		
	}//doGet() end

}//BringMeetingListByThemeNo end 

