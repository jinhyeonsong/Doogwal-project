package com.doogwal.coffee.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.dao.MeetAppsDAO;
import com.doogwal.coffee.vo.MeetApp;

@WebServlet("/bringMeeting.doo")
public class BringMeeting extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//기본 셋팅
		HttpSession session = req.getSession();
		
		//밋팅 번호, 주최 크루 번호, 데려올 크루 번호, 데려올 때 쓰는 포인트
		System.out.println(req.getParameter("meetingNo"));
		int meetingNo = Integer.parseInt(req.getParameter("meetingNo"));
		int bringCrewNo = Integer.parseInt(req.getParameter("bringCrewNo"));
		int point = Integer.parseInt(req.getParameter("point"));
		
		MeetApp meetApp = new MeetApp();
		meetApp.setMeetingNo(meetingNo);
		meetApp.setApplyCrewNo(bringCrewNo);
		meetApp.setIntroduce(Integer.toString(point));
		
		int organizeCrewNo = CrewsDAO.selectOrganizeMeetingCrew(meetingNo);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("no", organizeCrewNo);
		map.put("point", -point);
		
		//밋팅 데려오고
		int result1 = MeetAppsDAO.bringMeeting(meetApp);
		//포인트 수정하고
		int result2 = CrewsDAO.updateCrewPoint(map);
		
		//밋팅 데려오기 받은 크루에게 포인트 넣어주기
		map.put("no", bringCrewNo);
		map.put("point", point);
		
		int result3 = CrewsDAO.updateCrewPoint(map);
		System.out.println("result3 : "+result3);
		
		String referer = req.getHeader("referer");
		resp.sendRedirect(referer);
	}
}
