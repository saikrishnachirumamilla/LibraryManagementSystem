package com.library.management.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.library.management.system.dao.FinesDao;

@Service
public class FinesServiceImpl implements FinesService{

	@Autowired
	private FinesDao finesDao;

	@Override
	public String refreshFines() throws Exception {
		try {
			return finesDao.refreshFines();
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public String fetchFines(String cardno) throws Exception {
		try {
			List<List<Map<String, Object>>> finesList = finesDao.fetchFines(cardno);
			Gson gson = new Gson();
			return gson.toJson(finesList);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public String payFines(String cardno, String fine) throws Exception {
		try {
			return finesDao.payFines(cardno, fine);
		} catch (Exception e) {
			throw e;
		}
	}
}
