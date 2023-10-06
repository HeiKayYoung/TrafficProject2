package com.traffic.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Seoul_Parking;
import com.traffic.dto.user.DTO_Seoul_Ec_Charger;

public class Seoul_Electric_charge_View_Service implements Interface_TrafficService {
	
	IDao_Seoul_Parking dao;
	
	public Seoul_Electric_charge_View_Service(SqlSession sqlSession) {
		dao = sqlSession.getMapper(IDao_Seoul_Parking.class);
	}

	@Override
	public void execute(Model model) {
		
		System.out.println("ec_view_Service");
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String title = request.getParameter("title");
		System.out.println("title : "+title);
		
		DTO_Seoul_Ec_Charger ec_view = dao.ec_view(title);
		
		model.addAttribute("ec_view",ec_view);
		
	}

}
