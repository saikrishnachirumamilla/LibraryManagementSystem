package com.library.management.system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.management.system.dao.SearchDao;


@Service
public class SearchServiceImpl implements SearchService{
	
	@Autowired
	private SearchDao searchDao;
	
	public String getBooks(String name) throws Exception{
		try {
			return searchDao.getBooks(name);
		} catch (Exception e) {
			throw e;
		}
		
	}

}
