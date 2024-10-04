package GE.DAO;

import GE.model.Employee;
import io.vertx.core.Future;
import io.vertx.hibernate.reactive.ReactiveSession;
import io.vertx.hibernate.reactive.ReactiveSessionFactory;
import utils.HibernateUtil;

import java.util.List;

public class EmployeeDAO {

    private final ReactiveSessionFactory sessionFactory = HibernateUtil.getSessionFactory();

    public Future<Void> save(Employee employee) {
        try (ReactiveSession session = sessionFactory.openSession()) {
            return session.beginTransaction()
                    .compose(tx -> session.save(employee))
                    .compose(result -> session.getTransaction().commit())
                    .onFailure(err -> session.getTransaction().rollback());
        }
    }

    public Future<List<Employee>> fetchAllEmployees() {
        try (ReactiveSession session = sessionFactory.openSession()) {
            return session.createQuery("from Employee", Employee.class).getResultList();
        }
    }

    public Future<Boolean> update(Employee employee, int id) {
        try (ReactiveSession session = sessionFactory.openSession()) {
            return session.beginTransaction()
                    .compose(tx -> session.get(Employee.class, id))
                    .compose(existingEmployee -> {
                        if (existingEmployee != null) {
                            existingEmployee.setName(employee.getName());
                            existingEmployee.setEmail(employee.getEmail());
                            existingEmployee.setPhone(employee.getPhone());
                            existingEmployee.setPosition(employee.getPosition());
                            existingEmployee.setDepartment(employee.getDepartment());
                            return session.update(existingEmployee);
                        } else {
                            return Future.failedFuture("Employee not found with ID: " + id);
                        }
                    })
                    .compose(result -> session.getTransaction().commit().map(true))
                    .onFailure(err -> session.getTransaction().rollback());
        }
    }

    public Future<Boolean> delete(int employeeId) {
        try (ReactiveSession session = sessionFactory.openSession()) {
            return session.beginTransaction()
                    .compose(tx -> session.get(Employee.class, employeeId))
                    .compose(employee -> {
                        if (employee != null) {
                            return session.delete(employee).compose(v -> session.getTransaction().commit().map(true));
                        } else {
                            return Future.failedFuture("Employee not found with ID: " + employeeId);
                        }
                    })
                    .onFailure(err -> session.getTransaction().rollback());
        }
    }
}
