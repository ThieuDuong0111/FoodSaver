package com.funix.foodsaverAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Answer;

@Repository
public interface IAnswerRepository extends JpaRepository<Answer, Integer> {

}