package com.library.management.system.service;

public interface BorrowerService {
	
	public String insertBorrower(String ssn, String fname, String lname, String email, 
			String addr, String city, String state, String phn) throws Exception;
}
