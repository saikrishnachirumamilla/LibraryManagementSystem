package com.library.management.system.dao;

public interface BorrowerDao {
	public String insertBorrower(String ssn, String fname, String lname, String email, String addr, String city,
			String state, String phn, String date) throws Exception;
	
	public boolean checkBorrower(String ssn) throws Exception;
}
