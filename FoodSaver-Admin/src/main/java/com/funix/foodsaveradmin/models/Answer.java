package com.funix.foodsaveradmin.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.util.Date;

@Entity
@Table(name = "Answer")
public class Answer {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "feedback_id", nullable = false)
	private FeedBack feedback;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private MyUser userAnswer;

	@Column(columnDefinition = "TEXT")
	private String answer;

	private Boolean isCreator;

	private Date publishedDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public FeedBack getFeedback() {
		return feedback;
	}

	public void setFeedback(FeedBack feedback) {
		this.feedback = feedback;
	}

	public MyUser getUserAnswer() {
		return userAnswer;
	}

	public void setUserAnswer(MyUser userAnswer) {
		this.userAnswer = userAnswer;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Boolean getIsCreator() {
		return isCreator;
	}

	public void setIsCreator(Boolean isCreator) {
		this.isCreator = isCreator;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}

}
