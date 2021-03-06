package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.CrewAppsDAO;
import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.vo.User;
import com.doogwal.coffee.vo.QualificationJson;
import com.fasterxml.jackson.databind.ObjectMapper;


//크루 가입 대기자들의 정보를 담아놓는 json 생성
@WebServlet(value="/ajax/qualifications.json")
public class Qualifications extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		
		//크루 번호 받아오고
		int no = Integer.parseInt(req.getParameter("no"));
		//크루에 가입을 신청한 유저들 정보와, 크루의 가입조건을 가져옴
		List<User> registeWatingUsers = CrewAppsDAO.selectRegisteWatingUsers(no);
		List<String> crewQuests = CrewAppsDAO.selectQuest(no);
		List<String> waitingUserImgs = CrewMembersDAO.selectWatingCrewMemberImgs(no);
		//mybatis에 파라메터를 2개 보내기 위한 map
		Map<String, Integer> map = new HashMap<String, Integer>();
		//기다리는 유저들이 가져야할 정보를 담고있는 QualificationObj의 리스트
		List<QualificationJson> QualificationJsonObjs = new ArrayList<QualificationJson>();

		//QualificationObj 세팅
		map.put("crewNo",no);
		
		int idx = 0;
		for(User user : registeWatingUsers) {
			map.put("userNo",user.getNo());
			QualificationJsonObjs.add(new QualificationJson(user.getName(), waitingUserImgs.get(idx),user.getAddress(), user.getBirthDate(), CrewAppsDAO.selectIntro(user.getNo()), user.getRegdate(), crewQuests,CrewAppsDAO.selectUserAns(map), user.getNo(), no)); 
			idx++;
		}
		
		//json 생성
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(QualificationJsonObjs);
		out.print(json);
	}
}