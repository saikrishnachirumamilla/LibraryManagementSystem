package com.library.management.system.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.management.system.dao.CheckOutDao;

@Service
public class CheckOutServiceImpl implements CheckOutService{
	@Autowired
	private CheckOutDao checkOutDao;

	@Override
	public String checkOutBook(String isbn13, String cardNo) throws Exception {
		try {
			String checkBookId = checkBookId(isbn13);
			if(!checkBookId.equals("success")) {
				return checkBookId;
			}
			String checkBCardNo = checkBCardNo(cardNo);
			if(!checkBCardNo.equals("success")) {
				return checkBCardNo;
			}
			String checkAvailability = checkAvailability(isbn13);
			if(!checkAvailability.equals("success")) {
				return checkAvailability;
			}
			String checkSameUser = checkSameUser(isbn13, cardNo);
			if(!checkSameUser.equals("success")) {
				return checkSameUser;
			}
			String checkBookLimit = checkBookLimit(cardNo);
			if(!checkBookLimit.equals("success")) {
				return checkBookLimit;
			}
			
			 SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
             Date currentDate = new Date();
             Calendar calendar = Calendar.getInstance();
             calendar.setTime(currentDate); 
             calendar.add(Calendar.DATE, 14); 
             String dueDate = simpleDateFormat.format(calendar.getTime());
             String checkOutDate = simpleDateFormat.format(currentDate);
             return checkOutDao.checkOutBook(isbn13, cardNo, checkOutDate, dueDate);
			
		} catch (Exception e) {
			throw e;
		}
	}
	
	
	private String checkBookId(String isbn13) throws Exception {
		try {
			return checkOutDao.checkBookId(isbn13);
		} catch (Exception e) {
			throw e;
		}
	}
	
	private String checkBCardNo(String cardNo) throws Exception {
		try {
			return checkOutDao.checkBCardNo(cardNo);
		} catch (Exception e) {
			throw e;
		}
	}
	
	private String checkAvailability(String isbn13) throws Exception {
		try {
			return checkOutDao.checkAvailability(isbn13);
		} catch (Exception e) {
			throw e;
		}
	}
	
	private String checkSameUser(String isbn13, String cardNo) throws Exception {
		try {
			return checkOutDao.checkSameUser(isbn13, cardNo);
		} catch (Exception e) {
			throw e;
		}
	}
	
	private String checkBookLimit(String cardNo) throws Exception {
		try {
			return checkOutDao.checkBookLimit(cardNo);
		} catch (Exception e) {
			throw e;
		}
	}
	
	
	
}
