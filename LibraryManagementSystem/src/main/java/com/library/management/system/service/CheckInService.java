package com.library.management.system.service;

import java.util.List;
import java.util.Map;

public interface CheckInService {
	
	public String getCheckIn(String isbn13, String cardno, String bname) throws Exception;
	public String checkInBook(String isbn13, String cardno) throws Exception;
}
