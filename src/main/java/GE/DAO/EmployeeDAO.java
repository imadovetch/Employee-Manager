package GE.DAO;

import GE.model.Employee;
import org.hibernate.Session;
import org.hibernate.Transaction;
import utils.HibernateUtil;

public class EmployeeDAO {

    public void save(Employee employee) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(employee);
            transaction.commit();
        }catch (Exception e) {
            if(transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
