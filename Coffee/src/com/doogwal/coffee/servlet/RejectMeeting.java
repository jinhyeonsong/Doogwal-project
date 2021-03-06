package com.doogwal.coffee.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.MeetAppsDAO;

@WebServlet("/rejectMeeting.doo")
public class RejectMeeting extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//기본셋팅
		HttpSession session = req.getSession();
		
		//밋팅신청번호랑 밋팅번호 얻어오고
		int meetingAppNo = Integer.parseInt(req.getParameter("meetingAppNo"));
		
		//거절하기
		int result1 = MeetAppsDAO.updateRejectMeetingApp(meetingAppNo);
	}
}
