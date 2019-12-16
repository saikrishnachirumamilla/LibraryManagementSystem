package com.library.management.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.management.system.service.BorrowerService;

@Controller
@RequestMapping("/borrower")
public class BorrowerController {

	@Autowired
	private BorrowerService borrowerService;
	
	@RequestMapping(value = "/insert",method=RequestMethod.POST)
	public @ResponseBody String insertBorrower(HttpServletRequest request) {
		try {
			
			return borrowerService.insertBorrower(request.getParameter("ssn"),request.getParameter("fname"),
					request.getParameter("lname"),request.getParameter("email"),request.getParameter("addr"),
					request.getParameter("city"),request.getParameter("state"),request.getParameter("phn"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
	}
}