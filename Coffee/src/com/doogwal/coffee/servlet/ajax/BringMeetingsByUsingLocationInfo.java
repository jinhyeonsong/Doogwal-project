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



@WebServlet("/ajax/bringMeetingsByUsingLocationInfo.json")
public class BringMeetingsByUsingLocationInfo extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		System.out.println("여기로옴!");
		
		
		String locationInfo = req.getParameter("locationInfo");
		System.out.println(locationInfo);
		String locationInfo2 = "%"+locationInfo+"%";
		System.out.println(locationInfo2);
		
		List<Meeting> meetingsByLocationInfo = SchedulesDAO.selectMeetingListByUsingLocationInfo(locationInfo2);
		System.out.println(meetingsByLocationInfo);
		
		
		System.out.println("여기까지도 옴!");
		
		//ObjectMapper 객체
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(meetingsByLocationInfo);
		
		out.println(json);
		System.out.println(json);
		
		
		
		
		
	}//doGet() end

}//BringMeetingsByUsingLocationInfo end 

