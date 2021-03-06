package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.dao.FellowshipsDAO;
import com.doogwal.coffee.vo.Crew;
import com.doogwal.coffee.vo.CrewFellowshipManner;
import com.doogwal.coffee.vo.Fellowship;
import com.doogwal.coffee.vo.FellowshipCrew;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/get_review.json")
public class GetReview extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		int meetingNo = Integer.parseInt(req.getParameter("meetNo"));
		
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		map.put("meetingNo",meetingNo);
		map.put("rateeNo",crewNo);
		System.out.println("crewNo: " + crewNo + " meetingNo: "+ meetingNo);
		CrewFellowshipManner fellowship = FellowshipsDAO.selectByRateeNo(map);

		
		
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		ObjectMapper om =new ObjectMapper();
		String json = om.writeValueAsString(fellowship);
		out.println(json);	
		
	
		
	}
	
}
