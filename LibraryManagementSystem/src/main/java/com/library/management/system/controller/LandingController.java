package com.library.management.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LandingController {
	
	@RequestMapping("/home")
	public ModelAndView home() {
		return new ModelAndView("home");
	}
	@RequestMapping("/search")
	public ModelAndView search() {
		return new ModelAndView("search");
	}
	@RequestMapping("/loan")
	public ModelAndView loan() {
 
		return new ModelAndView("loan");
	}
	@RequestMapping("/fine")
	public ModelAndView fine() {
		return new ModelAndView("fine");
	}
	@RequestMapping("/borrower")
	public ModelAndView borrower() {
		return new ModelAndView("borrower");
	}

}
