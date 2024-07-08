package com.funix.foodsaverAPI.utils;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.UUID;

public class ParseUtils {
	public static String parseDateTime(Date dateTime) throws ParseException {

		SimpleDateFormat inputFormat = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss.S");
		SimpleDateFormat outputFormat = new SimpleDateFormat(
			"dd/MM/yyyy-HH:mm:ss");

		Date date = inputFormat.parse(dateTime.toString());

		return outputFormat.format(date);

	}

	public static String parseVNDCurrency(double amount) throws ParseException {

		DecimalFormat decimalFormat = new DecimalFormat("#,###");
		String formattedNumber = decimalFormat.format(amount);

		return formattedNumber + " VND";
	}

	public static String parseImageUrl(byte[] byteArray) throws ParseException {
		return UUID.nameUUIDFromBytes(byteArray)
			.toString()
			+ LocalDateTime.now().toString();
	}
}
