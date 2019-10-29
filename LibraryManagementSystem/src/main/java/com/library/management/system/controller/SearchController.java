package com.library.management.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.management.system.service.SearchService;


@Controller
@RequestMapping("/searchLMS")
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	
	@RequestMapping(value = "/getBooks",method=RequestMethod.POST)
	public @ResponseBody String getbooks(HttpServletRequest request) {
		try {
			return searchService.getBooks(request.getParameter("name"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
		
	}

}
