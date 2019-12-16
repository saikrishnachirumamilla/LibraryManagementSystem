package com.library.management.system.service;

public interface FinesService {
	public String refreshFines() throws Exception;
	public String fetchFines(String cardno) throws Exception;
	public String payFines(String cardno, String fine) throws Exception;
}
