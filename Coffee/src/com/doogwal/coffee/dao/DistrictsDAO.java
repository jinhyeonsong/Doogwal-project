package com.doogwal.coffee.dao;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.District;

public class DistrictsDAO {
	//박형우 start -----------------------------------------------------------------------
		//20210123 start
		
		//지역 이름으로 넘버 가져오는
		public static int selectDistrictNo(String name) {
				
				SqlSession session = null;
				
				try {
					session = SqlSessionUtil.getSession();
					
					return session.selectOne("districts.selectDistrictNo",name);
				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					session.close();
				}
				
				return -1;
		}
		
		//20210123 end
		//박형우 end -----------------------------------------------------------------------

		//송진현
		public static District selectOne(String name) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				return session.selectOne("districts.selectOne", name);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (session != null)
					session.close();
			} // try~catch~finally end
			
			return null;
		}// selectOne() end
		//end 송진현
}
