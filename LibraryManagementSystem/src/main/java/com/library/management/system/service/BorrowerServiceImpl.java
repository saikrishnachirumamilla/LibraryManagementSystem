package com.library.management.system.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.management.system.dao.BorrowerDao;

@Service
public class BorrowerServiceImpl implements BorrowerService{
	
	@Autowired
	private BorrowerDao borrowerDao;
	@Override
	public String insertBorrower(String ssn, String fname, String lname, String email, String addr, String city,
			String state, String phn) throws Exception {
		try {
			
			 SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
             Date currentDate = new Date();
             String date = simpleDateFormat.format(currentDate);
			
			if(!borrowerDao.checkBorrower(ssn)) {
				return borrowerDao.insertBorrower(ssn, fname, lname, email, addr, city, state, phn, date);
			}else {
				return "Borrower already exists. Please check the details again.";
			}
			
		} catch (Exception e) {
			throw e;
		}
	}
}
