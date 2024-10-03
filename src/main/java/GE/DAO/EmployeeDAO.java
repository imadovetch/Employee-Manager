package GE.DAO;

import GE.model.Employee;
import org.hibernate.Session;
import org.hibernate.Transaction;
import utils.HibernateUtil;

import java.util.List;

public class EmployeeDAO {

    public void save(Employee employee) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(employee);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<Employee> fetchAllEmployees() {
        Transaction transaction = null;
        List<Employee> employees = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            employees = session.createQuery("from Employee", Employee.class).list();
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return employees;
    }

    public boolean update(Employee employee,int id) {
        Transaction transaction = null;
        boolean isUpdated = false;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Employee existingEmployee = session.get(Employee.class, id);

            if (existingEmployee != null) {
                existingEmployee.setName(employee.getName());
                existingEmployee.setEmail(employee.getEmail());
                existingEmployee.setPhone(employee.getPhone());
                existingEmployee.setPosition(employee.getPosition());
                existingEmployee.setDepartment(employee.getDepartment());

                session.update(existingEmployee);
                transaction.commit();
                isUpdated = true;
            } else {
                System.out.println("Employee not found with ID: " + id);
            }
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return isUpdated;
    }

    public boolean delete(int employeeId) {
        Transaction transaction = null;
        boolean isDeleted = false;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Employee employee = session.get(Employee.class, employeeId);

            if (employee != null) {
                session.delete(employee);
                transaction.commit();
                isDeleted = true;
            } else {
                System.out.println("Employee not found with ID: " + employeeId);
            }
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }

        return isDeleted;
    }
}
