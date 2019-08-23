package com.yang.codingtest.exchange.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yang.codingtest.exchange.service.ExchangeService;

@Controller
public class ExchangeController {
	
	@Autowired
	private ExchangeService ExchangeService;
	
	@RequestMapping("exchange.do")
	public String exchange() {
		return "exchange/exchange";
	}
	
	@RequestMapping("getExchangeRate.do")
	public @ResponseBody String getExchangeRate(@RequestParam(value="country") String country, Model model) {
		
		String exchangeRate = ExchangeService.getExchangeRate(country);
		
		String exchangeRateStr = exchangeRate+" "+country+"/USD";
		
		model.addAttribute("exchangeRate", exchangeRateStr);


		//수정을 완료 합니다.

		return exchangeRateStr;
	}
	
}
