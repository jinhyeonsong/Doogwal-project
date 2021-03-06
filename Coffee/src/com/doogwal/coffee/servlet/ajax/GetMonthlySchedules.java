package com.doogwal.coffee.servlet.ajax;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.AttendancesDAO;
import com.doogwal.coffee.dao.SchedulesDAO;
import com.doogwal.coffee.vo.CrewCalendar;
import com.doogwal.coffee.vo.Meeting;
import com.fasterxml.jackson.databind.ObjectMapper;



@WebServlet("/ajax/getMonthlySchedules.json")
public class GetMonthlySchedules extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		
		
		String crewNoStr = req.getParameter("crewNo");
		//형변환
		int crewNo = Integer.parseInt(crewNoStr);
		System.out.println("monthly crew No"+crewNo);
		Timestamp startTime = null;
		String name = null;
		List<Meeting> monthlySchedules = SchedulesDAO.selectMonthlySchedules(crewNo);
		List<CrewCalendar> list = new ArrayList<CrewCalendar>();//여기에 일별 일정 리스트 넣어줄 것임.
		
		
		
		for(Meeting monthlySchedule:monthlySchedules) {
			System.out.println("여기까지 옴!");
			CrewCalendar crewCalendar = new CrewCalendar();
			startTime = monthlySchedule.getStartDate();//일정 시작 시간 얻기
			name = monthlySchedule.getName();
			System.out.println("일정명:"+name);
			crewCalendar.setName(name);
			crewCalendar.setStartDate(startTime);
			list.add(crewCalendar);
		}
		
		System.out.println("여기까지도 옴!");
		
		
		
		//ObjectMapper 객체
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(list);
		
		out.println(json);
		System.out.println(json);
		
		
		System.out.println("됐다!");
		
		
		
		
	}//doPost() end

}

