package com.funix.foodsaverAPI.utils;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageUtils {

	public static final int BITE_SIZE = 4 * 1024;

	public static byte[] resizeImage(byte[] imageData, int maxWidth,
		int maxHeight) throws IOException {
		ByteArrayInputStream input = new ByteArrayInputStream(imageData);
		BufferedImage originalImage = ImageIO.read(input);
		int originalWidth = originalImage.getWidth();
		int originalHeight = originalImage.getHeight();

		double scaleX = (double) maxWidth / originalWidth;
		double scaleY = (double) maxHeight / originalHeight;
		double scale = Math.min(scaleX, scaleY); // Chọn tỷ lệ nhỏ nhất để giữ
													// nguyên tỷ lệ

		// Tính toán kích thước mới dựa trên tỷ lệ scale
		int newWidth = (int) (originalWidth * scale);
		int newHeight = (int) (originalHeight * scale);

		// Tạo ảnh mới với kích thước đã tính toán
		BufferedImage resizedImage = new BufferedImage(newWidth, newHeight,
			BufferedImage.TYPE_INT_RGB);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
		g.dispose();

		// Chuyển ảnh đã resize thành mảng byte
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(resizedImage, "jpg", baos);
		return baos.toByteArray();
	}
}
