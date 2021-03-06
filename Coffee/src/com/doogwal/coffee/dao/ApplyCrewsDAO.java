package com.doogwal.coffee.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.ApplyCrew;


public class ApplyCrewsDAO {

	public static List<ApplyCrew> selectList(int no) {
		
		List<ApplyCrew> applycrews = null;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			applycrews = session.selectList("applycrews.selectList",no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) {
				session.close();
			}//if end
		}//try~catch~finally end
		
		return applycrews;
	}
}
