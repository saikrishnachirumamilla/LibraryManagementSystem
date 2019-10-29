package com.library.management.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.management.system.service.CheckOutService;

@Controller
@RequestMapping("/checkout")
public class CheckOutController {
	@Autowired
	private CheckOutService checkOutService;
	
	@RequestMapping(value = "/book",method=RequestMethod.POST)
	public @ResponseBody String checkOutBook(HttpServletRequest request) {
		try {
			
			return checkOutService.checkOutBook(request.getParameter("isbn"), request.getParameter("cardno"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
	}
}