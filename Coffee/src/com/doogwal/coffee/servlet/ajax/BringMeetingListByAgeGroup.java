package com.doogwal.coffee.servlet.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.doogwal.coffee.dao.SchedulesDAO;

import com.doogwal.coffee.vo.Meeting;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ajax/bringMeetingListByAgeGroup.json")
public class BringMeetingListByAgeGroup extends HttpServlet{

   //20210114 이아림 start
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
      
      String ageGroupStr = req.getParameter("ageGroup"); 
    
      
      Map<String, Object> datas = new ConcurrentHashMap<String, Object>();
      
     
      if(ageGroupStr!=null) {
         int ageGroup = Integer.parseInt(ageGroupStr);
         datas.put("minAge", ageGroup);
         datas.put("maxAge", ageGroup+10);
      }
      
      List<Meeting> list =  SchedulesDAO.selectMeetingListByAgeGroup(datas);
      
      ObjectMapper mapper = new ObjectMapper();
      
      String json = mapper.writeValueAsString(list);
      
      resp.setContentType("application/json;charset=UTF-8");
      
      PrintWriter out = resp.getWriter();
      
      out.print(json);
      
      
   }//doGet() end
   
}//BringMeetingListByAgeGroup end 