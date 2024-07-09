package com.funix.foodsaverAPI.models;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Cart")
public class Cart {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@OneToMany(mappedBy = "cart")
	private List<CartItem> cartItems;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private MyUser userCarts;

	private Date publishedDate;

	private Boolean isDone;

	public Cart() {
		super();
	}

	public Cart(List<CartItem> cartItems, MyUser userCarts, Date publishedDate,
		Boolean isDone) {
		super();
		this.cartItems = cartItems;
		this.userCarts = userCarts;
		this.publishedDate = publishedDate;
		this.isDone = isDone;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
	}

	public MyUser getUserCarts() {
		return userCarts;
	}

	public void setUserCarts(MyUser userCarts) {
		this.userCarts = userCarts;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}

	public Boolean getIsDone() {
		return isDone;
	}

	public void setIsDone(Boolean isDone) {
		this.isDone = isDone;
	}
}
