package com.doogwal.coffee.servlet.ajax;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.doogwal.coffee.dao.CrewMembersDAO;
import com.doogwal.coffee.util.ResizeImageUtil;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/ajax/uploadCrewMemberProfile.json")
public class UploadCrewMemberProfile extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//ServletContext
		ServletContext application 
		= req.getServletContext();
		
		//파일업로드의 경로
		String rootPath = 
			application.getRealPath("/");
		
		System.out.println(rootPath);
		
		String uploadPath = 
				rootPath+"upload"+File.separator;
		
		//프로필 사진 모아놓는 폴더 경로
		String profilePath = rootPath+"img/profile"+File.separator;
		
		System.out.println(uploadPath);
		
		//MultipartRequest객체를 생성
		MultipartRequest mr 
		= new MultipartRequest(req,
				uploadPath,
				1024*1024*100,
				"UTF-8",
				new DefaultFileRenamePolicy());
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		//업로드한 파일 이름 얻기
		String fileName = 
				mr.getFilesystemName("uploadImage");
		
		
		String crewMemberNoStr = mr.getParameter("crewMemberNo");
		String type = mr.getParameter("type");
		String seqStr = mr.getParameter("sequence");
		int crewMemberNo = Integer.parseInt(crewMemberNoStr);
		int seq = Integer.parseInt(seqStr); 
		
		switch(type) {
		case "P" : 
			ResizeImageUtil.resize(uploadPath+fileName,profilePath+fileName,100);
			break;
		case "B" : 
			break;
		}//switch end
		CrewMember crewMember = new CrewMember();
		crewMember.setNo(crewMemberNo);
		crewMember.setProfileImg(fileName);
		
		
		//마이페이지에서 새로고침 후에도 테이블 변경사항 반영되어있게 하기 위함.
		CrewMember userCrews = (CrewMember)req.getSession().getAttribute("userCrewList"+seq);
		userCrews.setNo(crewMemberNo);
		userCrews.setProfileImg(fileName);
		
	
		int result = CrewMembersDAO.updateProfileImage(crewMember);
		//응답
		PrintWriter out = resp.getWriter();
		//출력!
		out.print("{\"imageName\":\""+fileName+"\"}");
		
	}//doPost() end

}

