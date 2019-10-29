package com.library.management.system.service;

public interface CheckOutService {
	
	public String checkOutBook(String isbn13, String cardNo) throws Exception;
}
