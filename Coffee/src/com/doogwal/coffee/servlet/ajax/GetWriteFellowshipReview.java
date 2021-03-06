package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewsDAO;
import com.doogwal.coffee.vo.Crew;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/get_write_fellowship_review.json")
public class GetWriteFellowshipReview extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		
		Crew crew = CrewsDAO.selectCrewAllInformation(crewNo);
		
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		ObjectMapper om =new ObjectMapper();
		String json = om.writeValueAsString(crew);
		out.println(json);	
		
	
	}
	
}
