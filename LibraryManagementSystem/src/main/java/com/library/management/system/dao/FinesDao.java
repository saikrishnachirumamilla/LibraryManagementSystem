package com.library.management.system.dao;

import java.util.List;
import java.util.Map;

public interface FinesDao {
	
	public String refreshFines() throws Exception;
	public List<List<Map<String, Object>>> fetchFines(String cardno) throws Exception;
	public String payFines(String cardno, String fine) throws Exception;
}
