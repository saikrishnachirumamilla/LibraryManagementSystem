package com.library.management.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.management.system.service.FinesService;

@Controller
@RequestMapping("/fines")
public class FinesController {
	@Autowired 
	private FinesService finesService;
	
	@RequestMapping(value = "/refresh",method=RequestMethod.POST)
	public @ResponseBody String refreshFines(HttpServletRequest request) {
		try {
			return finesService.refreshFines();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
		
	}
	
	@RequestMapping(value = "/fetch",method=RequestMethod.POST)
	public @ResponseBody String fecthFines(HttpServletRequest request) {
		try {
			return finesService.fetchFines(request.getParameter("cardno"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
		
	}
	
	@RequestMapping(value = "/pay",method=RequestMethod.POST)
	public @ResponseBody String payFines(HttpServletRequest request) {
		try {
			return finesService.payFines(request.getParameter("cardno"), request.getParameter("fine"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
		
	}
}
