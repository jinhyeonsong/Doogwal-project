package com.doogwal.coffee.servlet.ajax;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.AttendancesDAO;
import com.doogwal.coffee.dao.MeetAppsDAO;
import com.doogwal.coffee.dao.MeetingsDAO;
import com.doogwal.coffee.dao.SchedulesDAO;
import com.doogwal.coffee.vo.Crew;
import com.doogwal.coffee.vo.CrewCalendar;

import com.doogwal.coffee.vo.Meeting;
import com.fasterxml.jackson.databind.ObjectMapper;



@WebServlet("/ajax/getAllScheduleList.json")
public class GetAllScheduleList extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		
		
		String crewNoStr = req.getParameter("crewNo");//crewNo에 해당하는 스케줄 가져와야 해서 필요함.
		int crewNo = Integer.parseInt(crewNoStr);
		
		List<Meeting> allSchedules = SchedulesDAO.selectAllSchedules(crewNo);
				
		if(allSchedules!=null) {
		//모임에 필요한 정보들
		int scheduleNo = 0;
		int point = 0;
		char type = 'G';
		int participantsTotal = 0;
		int nonParticipantsTotal = 0;
		String applyCrewName = null;
		String applyCrewImg = null;
		String name = null;//모임 이름
		Timestamp startTime = null;
		
		List<CrewCalendar> list = new ArrayList<CrewCalendar>();//여기에 일별 일정 리스트 넣어줄 것임.
		
		Crew applyCrew = new Crew();
		
		for(Meeting allSchedule: allSchedules) {
			CrewCalendar crewCalendar = new CrewCalendar();
			
			scheduleNo = allSchedule.getNo();//스케줄 번호 얻기
			type = allSchedule.getType();//스케줄 타입 얻기 G,F,M 이렇게 있음.
			
			name= allSchedule.getName();//일정 이름 얻기 
			startTime = allSchedule.getStartDate();//일정 시작 시간 얻기
			crewCalendar.setType(type);//CrewCalendar 객체에 타입 지정 해주기
			
			if(type=='G') {
			participantsTotal = AttendancesDAO.selectTotalParticipants(scheduleNo);
			nonParticipantsTotal = AttendancesDAO.selectTotalNonParticipants(scheduleNo);
			crewCalendar.setParticipantsTotal(participantsTotal);
			crewCalendar.setNonParticipantsTotal(nonParticipantsTotal);
			crewCalendar.setNo(scheduleNo);
			crewCalendar.setName(name);//일정 이름 
			crewCalendar.setStartDate(startTime);//String형 startTimeStr로 형 변환해서 넣어줄 것임.
			list.add(crewCalendar);
			}else if(type=='M'||type=='F') {
				applyCrew = MeetAppsDAO.selectCrewInteractingWith(scheduleNo);//스케줄 번호에 맞는 상대 크루 정보 얻어오기 위함 
				if(applyCrew!=null) {
				point = MeetingsDAO.selectMeetingPoint(scheduleNo);
				applyCrewName = applyCrew.getName();
				applyCrewImg = applyCrew.getCoverImg();
				crewCalendar.setPoint(point);
				crewCalendar.setApplyCrewName(applyCrewName);
				crewCalendar.setApplyCrewImg(applyCrewImg);
				crewCalendar.setNo(scheduleNo);
				crewCalendar.setName(name);//일정 이름 
				crewCalendar.setStartDate(startTime);//String형 startTimeStr로 형 변환해서 넣어줄 것임.
				list.add(crewCalendar);
				}
			}//if~else if end
			

		}
		
		//ObjectMapper 객체
		ObjectMapper om = new ObjectMapper();
		
		String json = om.writeValueAsString(list);
		out.println(json);
		System.out.println(json);
		
		}//if end 
		
	}//doPost() end

}//GetDailyScheduleList end 

