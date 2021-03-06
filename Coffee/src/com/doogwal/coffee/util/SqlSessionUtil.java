package com.doogwal.coffee.util;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionUtil {
	private static SqlSessionFactory factory;
	
	static {
		try {
			Reader reader = Resources.getResourceAsReader("/com/doogwal/coffee/config/mybatis-config.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
		}catch(Exception e) {
			e.printStackTrace();
		}// try~catch end
	}//static 영역
	
	public static SqlSession getSession() throws Exception {
		return factory.openSession(true);
	}//getSession end
}// SqlSessionUtil end


