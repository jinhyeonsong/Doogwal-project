package com.doogwal.coffee.servlet;

import java.io.IOException;
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
import javax.servlet.http.HttpSession;

import com.doogwal.coffee.dao.DistrictsDAO;
import com.doogwal.coffee.dao.MeetingsDAO;
import com.doogwal.coffee.dao.PreparationsDAO;
import com.doogwal.coffee.dao.RulesDAO;
import com.doogwal.coffee.dao.SchedulesDAO;
import com.doogwal.coffee.vo.Meeting;

@WebServlet("/makingMeeting.doo")
public class MakingMeeting extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//한글 안 깨지게 세션 받아오고
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		//파라메터들 가져오고
		char partDropdown = req.getParameter("partDropdown").charAt(0);
		String meetingName = req.getParameter("meetingNameInput");
		String dateStr = req.getParameter("datepicker_input");
		String timePickerValueTube = req.getParameter("timePickerValueTube");
		String timePickerValueTube2 = req.getParameter("timePickerValueTube2");
		int themeDropdown = Integer.parseInt(req.getParameter("themeDropdown"));
		String address = req.getParameter("sample5_address");
		String specifyAddress = req.getParameter("specifyAddressInput");
		int meetingCategoryChoice = Integer.parseInt(req.getParameter("meetingCategoryChoice"));
		String meetingImage = req.getParameter("meetingImageInput");
		int meetingPoint = Integer.parseInt(req.getParameter("meetingPointInput"));
		String meetingExplanation = req.getParameter("meetingExplanationInput");
		String rulesStr = req.getParameter("rulesInput");
		String materialsStr = req.getParameter("materialsInput");
		String strForDistrictNo = req.getParameter("strForDistrictNo");
		int crewNo = Integer.parseInt(req.getParameter("crewNo"));
		Double lat = Double.parseDouble(req.getParameter("latStr"));
		Double lng = Double.parseDouble(req.getParameter("lngStr"));

		//데이터를 내가 원하는 형태로 다듬기
		String[] rules = rulesStr.split(",");
		String[] materials = materialsStr.split(",");
		String dateYear = dateStr.substring(0, 4);
		String dateMonth = dateStr.substring(6, 8);
		String dateDay = dateStr.substring(10, 12);
		dateStr = dateYear+"-"+dateMonth+"-"+dateDay;
		timePickerValueTube = timePickerValueTube+":00";
		timePickerValueTube2 = timePickerValueTube2+":00";
		String startTimestampStr = dateStr+" "+timePickerValueTube;
		String endTimestampStr = dateStr+" "+timePickerValueTube2;
		Timestamp startTimestamp = Timestamp.valueOf(startTimestampStr); 
		Timestamp endTimestamp = Timestamp.valueOf(endTimestampStr); 
		int districtNo = DistrictsDAO.selectDistrictNo(strForDistrictNo);
	
		//insert할 객체 생성
		Meeting meeting = new Meeting();
		meeting.setType(partDropdown);
		meeting.setName(meetingName);
		meeting.setThemeNo(themeDropdown);
		meeting.setAddress(address);
		meeting.setPlace(specifyAddress);
		meeting.setCategoryNo(meetingCategoryChoice);
		meeting.setImg(meetingImage);
		meeting.setPoint(meetingPoint);
		meeting.setDescription(meetingExplanation);
		meeting.setConfirmation('W');
		meeting.setLat(lat);
		meeting.setLng(lng);
		meeting.setStartDate(startTimestamp);
		meeting.setEndDate(endTimestamp);
		meeting.setDistrictNo(districtNo);
		meeting.setCrewNo(crewNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//스케쥴,밋팅 테이블에 집어넣고
		int result1= SchedulesDAO.insertMakingMeeting(meeting);
		int result2 = MeetingsDAO.insertMakingMeeting(meeting);
		
		//룰,준비물 테이블에 집어넣고
		map.put("meetingNo", meeting.getNo());
		int result3, result4;
		
		for(String rule : rules) {
			map.put("rule", rule);
			result3 = RulesDAO.insertMeetingRule(map);
		}
		for(String material : materials) {
			map.put("preparation", material);
			result4 = PreparationsDAO.insertMeetingPreparation(map);
		}
		
		String referer = req.getHeader("referer");
		resp.sendRedirect(referer);
	}
}
