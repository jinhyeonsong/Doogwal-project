package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.MeetAppsDAO;
import com.doogwal.coffee.vo.MeetApp;

@WebServlet(value="/ajax/toApplyCrew")
public class ToApplyCrew extends HttpServlet{

	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.setCharacterEncoding("utf-8");  

		String introduce = req.getParameter("introduce");
	
		String crewNoStr = req.getParameter("crewNo");
		int crewNo = Integer.valueOf(crewNoStr);
		String meetingNoStr = req.getParameter("meetingNo");
		int meetingNo = Integer.valueOf(meetingNoStr);
		
		MeetApp meetapp = new MeetApp(meetingNo,crewNo,introduce);
		MeetAppsDAO.insert(meetapp);
		System.out.print("밋팅 신청 성공");
	}	
}






