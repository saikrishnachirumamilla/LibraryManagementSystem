package com.library.management.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.management.system.service.CheckInService;

@Controller
@RequestMapping("/checkin")
public class CheckInController {
	
	@Autowired
	private CheckInService checkInService;
	
	@RequestMapping(value = "/list",method=RequestMethod.POST)
	public @ResponseBody String insertBorrower(HttpServletRequest request) {
		try {
			
			return checkInService.getCheckIn(request.getParameter("isbn"), request.getParameter("cardno"), request.getParameter("bname"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
	}
	
	@RequestMapping(value = "/book",method=RequestMethod.POST)
	public @ResponseBody String checkInBook(HttpServletRequest request) {
		try {
			
			return checkInService.checkInBook(request.getParameter("isbn13"), request.getParameter("cardno"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
	}
}
