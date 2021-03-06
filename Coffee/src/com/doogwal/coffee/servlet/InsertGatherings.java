package com.doogwal.coffee.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.coyote.RequestGroupInfo;

import com.doogwal.coffee.dao.AttendancesDAO;
import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.dao.DistrictsDAO;
import com.doogwal.coffee.dao.GatheringsDAO;
import com.doogwal.coffee.dao.PreparationsDAO;
import com.doogwal.coffee.dao.SchedulesDAO;
import com.doogwal.coffee.vo.Attendance;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.District;
import com.doogwal.coffee.vo.Gathering;
import com.doogwal.coffee.vo.Preparation;

 @WebServlet("/gatheringRegister.coffee")
 
 public class InsertGatherings extends HttpServlet{
	 
 @Override
 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
	 req.setCharacterEncoding("utf-8");  
	 
	 String startTime = req.getParameter("startTime"); //시작시간
	 String endTime = req.getParameter("endTime"); //종료시간
	 String date = req.getParameter("date"); //날짜
	 String name = req.getParameter("name"); //이름
	 String address = req.getParameter("address"); //주소
	 String description = req.getParameter("description"); //상세설명
	 String feeString = req.getParameter("fee"); //회비
	 String preparation = req.getParameter("preparation"); //준비물 
	 String location = req.getParameter("location"); //좌표
	 String allDay = req.getParameter("allDay"); //하루종일 radio_checked(on/null)
	 String crewStr = req.getParameter("crewNo");
	 int fee = Integer.parseInt(feeString); //회비 int형으로 변환
	 int crewNo = Integer.parseInt(crewStr); 
	 
	 Timestamp startDate = Timestamp.valueOf("2020-01-01 00:00:00"); // 문자열 합치고 Timestamp타입으로 변환 0000-00-00 00:00:00
	 Timestamp endDate = Timestamp.valueOf("2020-01-01 00:00:00");
	
	 if(allDay!=null && allDay.equals("on")) { //null을 받기 때문이다. 라디오체크에 값을 주지않아서 체크안하면 null을받음
		 startDate = Timestamp.valueOf(date+" "+"12:00:00"); // 문자열 합치고 Timestamp타입으로 변환 0000-00-00 00:00:00
		 endDate = Timestamp.valueOf(date+" "+"23:59:00"); // 문자열 합치고 Timestamp타입으로 변환 0000-00-00 00:00:00
	 }else {
		 startDate = Timestamp.valueOf(date+" "+startTime+":00"); // 문자열 합치고 Timestamp타입으로 변환 0000-00-00 00:00:00
		 endDate = Timestamp.valueOf(date+" "+endTime+":00"); // 문자열 합치고 Timestamp타입으로 변환 0000-00-00 00:00:00
	 }
 
	 String[] array = location.split(","); //{00.0000,00.0000}의 문자열을 받았으니 ','을 기준으로 문자열 자르기
	 double lat = Double.parseDouble(array[0].substring(1)); //위도
	 String lngt = array[1]; //'}'을 자르기 위해  문자열로 변환
	 double lng = Double.parseDouble(lngt.substring(1,lngt.length()-1)); //경도
	 
	 char type = 'G'; //TYPE (G는 모임)
	 
	 String[] addressToken = address.split(" "); //문자열 자르기
	 District district = DistrictsDAO.selectOne(addressToken[1]); //행정구역 번호 받아옴 
	 int districtNo = district.getNo(); //행정구역 번호
	 
	 Gathering schedule = new Gathering(districtNo, crewNo, type, startDate, endDate, name, address, description, lat, lng); //스케줄 객체 생성
	 SchedulesDAO.insert(schedule); //insert
	 
	 int schedualNo = schedule.getNo();
	 
	 Gathering gathering = new Gathering(schedualNo,fee); //모임 객체생성
	 GatheringsDAO.insert(gathering); //insert
	 
	 String[] preparationToken = preparation.split(",");
	 int idx = 0;
	 while(idx<preparationToken.length) {
		 Preparation preparations = new Preparation(schedualNo,preparationToken[idx]); 
		 PreparationsDAO.insert(preparations);
		 idx++;
	 }
	 
	 List<CrewMember> crewmembers = CrewMembersDAO.selectList(crewNo);
	 for(CrewMember crewmember: crewmembers ) {
		 Attendance attendance = new Attendance(schedualNo,crewmember.getNo());
		 AttendancesDAO.insertList(attendance);
	 }
	 
	 String referer = req.getHeader("referer");
	 resp.sendRedirect(referer);
 }
}		


 
 
 

 
