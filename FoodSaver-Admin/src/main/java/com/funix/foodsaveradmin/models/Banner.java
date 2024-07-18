package com.funix.foodsaveradmin.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name = "Banner")
public class Banner {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(length = 100)
	private String name;

	@Lob
	@Column(columnDefinition = "MEDIUMBLOB")
	private String image;

	@Column(columnDefinition = "TEXT")
	private String imageUrl;

	@Column(length = 20)
	private String imageType;

	public Banner() {
		super();
	}

	public Banner(int id, String name, String image, String imageUrl,
		String imageType) {
		super();
		this.id = id;
		this.name = name;
		this.image = image;
		this.imageUrl = imageUrl;
		this.imageType = imageType;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getImageType() {
		return imageType;
	}

	public void setImageType(String imageType) {
		this.imageType = imageType;
	}
}
