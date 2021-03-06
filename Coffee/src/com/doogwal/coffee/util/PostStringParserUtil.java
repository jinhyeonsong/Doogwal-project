package com.doogwal.coffee.util;

import java.util.ArrayList;
import java.util.List;

public class PostStringParserUtil {

	public static List<String> PostImagesParserUtil(String str,String del1, String del2) { 
		
		String origin="";
		String save ="";
		List<String> listSave = new ArrayList<String>();
		int index=0;
		while(0<str.length()) {
			
			// 더이상 img file이 없을때 종료
			if(str.indexOf(del1)<0) {
				origin+=str;
				break;
			}
			// 글 저장
			origin+=str.substring(index, str.indexOf(del1));
			listSave.add(str.substring(str.indexOf(del1)+del1.length()+1,str.indexOf(del2)));
			str = str.substring(str.indexOf(del2)+2);
		}
		return listSave;
	}
	
	public static String contenetsOriginParserUtil(String str,String del1, String del2) { 
		String origin="";
		int index=0;
		while(0<str.length()) {
			// 더이상 img file이 없을때 종료
			if(str.indexOf(del1)<0) {
				origin+=str;
				break;
			}
			// 글 저장
			origin+=str.substring(index, str.indexOf(del1));
			str = str.substring(str.indexOf(del2)+2);
		}
		// 이미지 빈 태그들 없애기
		origin = origin.replaceAll("<p>[\\s]*</p>", "");
		return origin;
	}
}