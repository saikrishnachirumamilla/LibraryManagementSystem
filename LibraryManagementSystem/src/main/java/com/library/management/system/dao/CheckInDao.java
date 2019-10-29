package com.library.management.system.dao;

import java.util.List;
import java.util.Map;

public interface CheckInDao {
	
	public List<Map<String,Object>> getCheckIn(String isbn13, String cardno, String bname) throws Exception;
	public String checkInBook(String isbn13, String cardno, String checkInDate) throws Exception;
}
