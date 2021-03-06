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

import com.doogwal.coffee.dao.MeetingsDAO;
import com.doogwal.coffee.vo.Meeting;
import com.doogwal.coffee.vo.OngoingMeeting;
import com.fasterxml.jackson.databind.ObjectMapper;

//자기가 들어가있는 크루에서 주최한 밋팅들 받아오는
@WebServlet("/ajax/ongoingMeetings.json")
public class OngoingMeetings extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//기본 세팅
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//유저 번호 받아오고
		int userNo = Integer.parseInt(req.getParameter("userNo"));
		
		//필요한 정보 받아온다.
		List<OngoingMeeting> ongoingMeetings = MeetingsDAO.selectOngoingMeetings(userNo);
		int seq = 0;
		for(OngoingMeeting meeting : ongoingMeetings) {
			meeting.setSeq(++seq);
		}
		
		//json 생성
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(ongoingMeetings);
		out.print(json);
	}
}
