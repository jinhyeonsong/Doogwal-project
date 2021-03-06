package com.doogwal.coffee.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.MeetAppsDAO;
import com.doogwal.coffee.dao.MeetingsDAO;
import com.doogwal.coffee.dao.RecordsDAO;
import com.doogwal.coffee.dao.SchedulesDAO;
import com.doogwal.coffee.vo.Meeting;
import com.doogwal.coffee.vo.Record;

@WebServlet("/acceptMeeting.doo")
public class AcceptMeeting extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//기본셋팅
		HttpSession session = req.getSession();
		
		//밋팅신청번호랑 밋팅번호 얻어오고
		int meetingAppNo = Integer.parseInt(req.getParameter("meetingAppNo"));
		int meetingNo = Integer.parseInt(req.getParameter("meetingNo"));
		int applyCrewNo = Integer.parseInt(req.getParameter("applyCrewNo"));
		
		//밋팅 수락하고
		int result1 = MeetAppsDAO.updateAcceptMeetingApp(meetingAppNo);
		System.out.println("result1 : "+result1);
		int result2 = MeetingsDAO.updateAcceptMeetingApp(meetingNo);
		System.out.println("result2 : "+result2);
		int result3 = MeetAppsDAO.updateAcceptMeetingAppAfter(meetingNo);
		System.out.println("result3 : "+result3);
		
		//밋팅 정보 카피해와서
		Meeting meeting1 = SchedulesDAO.selectOneScheduleInformation(meetingNo);
		int organizeCrewNo = meeting1.getCrewNo(); // record삽입시 필요한 데이터
		meeting1.setCrewNo(applyCrewNo);
		Meeting meeting2 = MeetingsDAO.selectOneMeetingInformation(meetingNo);
		
		//수락받은 크루 일정에도 밋팅을 생성
		int result4 = SchedulesDAO.insertAcceptMeeing(meeting2);
		System.out.println("result4 : "+result4);
		int result5 = MeetingsDAO.insertAcceptMeeing(meeting1);
		System.out.println("result5 : "+result5);
		
		//record도 삽입
		Record record1 = new Record();
		record1.setCrewNo(organizeCrewNo);
		record1.setMeetingNo(meetingNo);
		Record record2 = new Record();
		record2.setCrewNo(applyCrewNo);
		record2.setMeetingNo(meetingNo);
		
		int result6 = RecordsDAO.insertRecord(record1);
		System.out.println("result6 : "+result6);
		int result7 = RecordsDAO.insertRecord(record2);
		System.out.println("result7 : "+result7);
	}
}
