package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.AttendancesDAO;
import com.doogwal.coffee.vo.Attendance;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet(value="/ajax/attendanceList.json")
public class AttendanceList extends HttpServlet{

	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		resp.setContentType("application/json; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
	
		String noStr = req.getParameter("no");
		int no = Integer.valueOf(noStr);
		
		String crewMemberNoStr = req.getParameter("number");
		int number = Integer.valueOf(crewMemberNoStr);
		
		String attendanceStr = req.getParameter("type");
		char attendance = attendanceStr.charAt(0);
		
		Attendance attendanceUpdate = new Attendance(no,number,attendance);
		if(attendance!='X')
		AttendancesDAO.update(attendanceUpdate);
		
		List<Attendance> attendances = AttendancesDAO.selectList(no);
		ObjectMapper om =new ObjectMapper();
		String json = om.writeValueAsString(attendances);
		out.println(json);
		
	}	
}






