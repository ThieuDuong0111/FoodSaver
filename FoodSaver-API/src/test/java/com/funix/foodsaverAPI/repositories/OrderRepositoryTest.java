package com.funix.foodsaverAPI.repositories;

import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.Order;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.Date;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class OrderRepositoryTest {

	@Autowired
	private TestEntityManager entityManager;

	@Autowired
	private IOrderRepository orderRepository;

	@Test
	public void testSaveOrder() {
		// Given
		MyUser user = new MyUser();
		user.setName("testuser");
		entityManager.persist(user);
		entityManager.flush();

		Order order = new Order(user, new Date(), "ORD-001", false, 1,
			"Creator", 1, 1);

		// When
		Order savedOrder = orderRepository.save(order);

		// Then
		assertThat(savedOrder.getId()).isNotNull();
		assertThat(savedOrder.getOrderCode()).isEqualTo(order.getOrderCode());
	}

	@Test
	public void testFindById() {
		// Given
		MyUser user = new MyUser();
		user.setName("testuser");
		entityManager.persist(user);
		entityManager.flush();

		Order order = new Order(user, new Date(), "ORD-001", false, 1,
			"Creator", 1, 1);
		entityManager.persistAndFlush(order);

		// When
		Optional<Order> foundOrder = orderRepository.findById(order.getId());

		// Then
		assertThat(foundOrder).isPresent();
		assertThat(foundOrder.get().getOrderCode())
			.isEqualTo(order.getOrderCode());
	}

	@Test
	public void testFindAll() {
		// Given
		MyUser user = new MyUser();
		user.setName("testuser");
		entityManager.persist(user);
		entityManager.flush();

		Order order1 = new Order(user, new Date(), "ORD-001", false, 1,
			"Creator", 1, 1);
		entityManager.persist(order1);
		Order order2 = new Order(user, new Date(), "ORD-002", false, 1,
			"Creator", 1, 1);
		entityManager.persist(order2);
		entityManager.flush();

		// When
		Iterable<Order> orders = orderRepository.findAll();

		// Then
		assertThat(orders).hasSizeGreaterThan(1);
	}

	@Test
	public void testDeleteOrder() {
		// Given
		MyUser user = new MyUser();
		user.setName("testuser");
		entityManager.persist(user);
		entityManager.flush();

		Order order = new Order(user, new Date(), "ORD-001", false, 1,
			"Creator", 1, 1);
		entityManager.persistAndFlush(order);

		// When
		orderRepository.deleteById(order.getId());

		// Then
		assertThat(orderRepository.findById(order.getId())).isEmpty();
	}
}
