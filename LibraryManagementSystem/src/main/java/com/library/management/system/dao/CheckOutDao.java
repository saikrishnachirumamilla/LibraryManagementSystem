package com.library.management.system.dao;

public interface CheckOutDao {

	public String checkBookId(String isbn13) throws Exception;

	public String checkBCardNo(String cardNo) throws Exception;

	public String checkAvailability(String isbn13) throws Exception;

	public String checkSameUser(String isbn13, String cardNo) throws Exception;

	public String checkBookLimit(String cardNo) throws Exception;
	
	public String checkOutBook(String isbn13, String cardNo, String checkOutDate, String dueDate) throws Exception; 
	
}
