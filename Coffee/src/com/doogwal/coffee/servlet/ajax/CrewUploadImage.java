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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet(value="/ajax/UploadCrewImage.json")
public class CrewUploadImage extends HttpServlet {

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
		
		System.out.println(uploadPath);
		
		// MultipartRequest객체를 생성 
		// multipart-formdata를 넘겼을때 일반적으로 req로 처리할 수 없어서 cos 라이브러리를 사용
		MultipartRequest mr = new MultipartRequest(req,
				uploadPath,
				1024*1024*100,
				"UTF-8",
				new DefaultFileRenamePolicy());
		
		//응답 content type을 지정
		resp.setContentType("application/json; charset=UTF-8");
		
		//업로드한 파일 이름 얻기
		
		//업로드한 파일 이름 얻기
		String fileName = 
				mr.getFilesystemName("uploadImage");
		
		//PostImg postImg = new PostImg(postNo, fileName);
		
		
		System.out.println(fileName);
		
		//응답
		PrintWriter out = resp.getWriter();
		out.print("{\"imageName\":\""+fileName+"\"}");
	}
	
}
