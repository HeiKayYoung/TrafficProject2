package com.traffic.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.traffic.service.main.Interface_Traffic_main_Service;
import com.traffic.service.main.Service_subway_airquality_user;
import com.traffic.service.main.Service_subway_disabil_fac;
import com.traffic.service.main.Service_subway_safety_detail;
import com.traffic.service.main.Service_subway_safety_info;

@Controller
@RequestMapping("user")
public class Controller_Subway {

	@Autowired
	private SqlSession sqlSession;
	private Interface_Traffic_main_Service service;

	@RequestMapping("/sairquality")
	public String sairquality(Model model) {

		service = new Service_subway_airquality_user(sqlSession);
		service.execute(model);

		return "traffic/sairquality";

	}

	@RequestMapping("/ssafety_info")
	public String ssafety_info(Model model) {

		service = new Service_subway_safety_info(sqlSession);
		service.execute(model);

		return "traffic/ssafety_info";

	}

	@RequestMapping("/ssafety_info_detail")
	public String ssafety_info_detail(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_safety_detail(sqlSession);
		service.execute(model);

		return "traffic/ssafety_info_detail";

	}

	@RequestMapping("/s_info_disability_fac")
	public String s_info_disability_fac(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_disabil_fac(sqlSession);
		service.execute(model);

		return "traffic/s_info_disability_fac";

	}

	@RequestMapping("/s_info_disability_fac_ev")
	public String s_info_disability_fac_ev(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_disabil_fac(sqlSession);
		service.execute(model);

		return "traffic/s_info_disability_fac_ev";

	}

	@RequestMapping("/s_info_disability_fac_wl")
	public String s_info_disability_fac_wl(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_disabil_fac(sqlSession);
		service.execute(model);

		return "traffic/s_info_disability_fac_wl";

	}

	

}
