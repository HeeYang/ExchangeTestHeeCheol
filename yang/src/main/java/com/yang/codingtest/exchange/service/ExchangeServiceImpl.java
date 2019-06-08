package com.yang.codingtest.exchange.service;

import java.net.URI;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ExchangeServiceImpl implements ExchangeService {

	public String getExchangeRate(String country) {
		String exchangeRate = "";
		try {
			RestTemplate restTemplate = new RestTemplate();

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);// JSON 변환

			HttpEntity entity = new HttpEntity<String>("parameters", headers);
			String strUrl = "http://www.apilayer.net/api/live?access_key=ae29b380d210e06c8cc7edff6b45b88f&currencies="+country;
			URI url = URI.create(strUrl);

			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject;

			jsonObject = (JSONObject) jsonParser.parse(response.getBody().toString());
			jsonObject = (JSONObject) jsonParser.parse(jsonObject.get("quotes").toString());
			
			exchangeRate = jsonObject.get("USD"+country).toString();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exchangeRate;
	}

}
