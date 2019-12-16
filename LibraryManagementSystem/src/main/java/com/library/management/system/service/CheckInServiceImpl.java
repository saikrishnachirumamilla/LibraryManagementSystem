package com.library.management.system.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.library.management.system.dao.CheckInDao;

@Service
public class CheckInServiceImpl implements CheckInService{

	@Autowired
	private CheckInDao checkInDao;

	@Override
	public String getCheckIn(String isbn13, String cardno, String bname) throws Exception {
		try {
			List<Map<String, Object>> checkiInList = checkInDao.getCheckIn(isbn13, cardno, bname);
			Gson gson = new Gson();
			return gson.toJson(checkiInList);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public String checkInBook(String isbn13, String cardno) throws Exception {
		try {
			 SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
             Date currentDate = new Date();
			String checkInDate = simpleDateFormat.format(currentDate);;
			return checkInDao.checkInBook(isbn13, cardno, checkInDate);
			
		} catch (Exception e) {
			throw e;
		}
	}
	
}
