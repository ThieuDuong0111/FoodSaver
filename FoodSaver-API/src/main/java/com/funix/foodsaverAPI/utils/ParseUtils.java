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

	public static String generateOrderCode() throws ParseException {
		return UUID.randomUUID().toString();
	}

	public static Boolean checkIsExpired(Date expiredDate) {
		Date currentDate = new Date();
		if (expiredDate.before(currentDate)
			|| expiredDate.equals(currentDate)) {
			return true;
		} else {
			return false;
		}
	}

	public static String convertStatusType(int statusType) {
		switch (statusType) {
		case 0: {
			return "Đang chờ";
		}
		case 1: {
			return "Xác nhận";
		}
		case 2: {
			return "Đã hủy";
		}
		case 3: {
			return "Hoàn thành";
		}
		default:
			return "";
		}
	}

	public static String convertPaymentType(int statusType) {
		switch (statusType) {
		case 0: {
			return "Tiền mặt";
		}
		case 1: {
			return "Chuyển khoản";
		}
		default:
			return "";
		}
	}
}
