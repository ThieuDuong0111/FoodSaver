package com.funix.foodsaveradmin.models;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Product")
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;

	@ManyToOne
	@JoinColumn(name = "creator_id")
	private MyUser creator;

	@ManyToOne
	@JoinColumn(name = "unit_id")
	private Unit unit;

	@OneToMany(mappedBy = "cartProduct")
	private List<CartItem> cartItems;

	@OneToMany(mappedBy = "productFeedBacks")
	private List<FeedBack> feedBacks;

	@Column(length = 100)
	private String name;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Lob
	@Column(columnDefinition = "MEDIUMBLOB")
	private String image;

	@Column(columnDefinition = "TEXT")
	private String imageUrl;

	@Column(length = 20)
	private String imageType;

	private double price;

	private double discountPrice;

	private int quantity;

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(double discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public MyUser getCreator() {
		return creator;
	}

	public void setCreator(MyUser creator) {
		this.creator = creator;
	}

	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
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

	public List<FeedBack> getFeedBacks() {
		return feedBacks;
	}

	public void setFeedBacks(List<FeedBack> feedBacks) {
		this.feedBacks = feedBacks;
	}

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}
}
