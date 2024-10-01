package GE;

import org.hibernate.Session;
import org.hibernate.Transaction;
import utils.HibernateUtil;

public class TestConnection {
    public static void testHibernateConnection() {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Begin a transaction
            transaction = session.beginTransaction();

            // Dummy query to test the connection
            String sql = "SELECT 1";
            session.createNativeQuery(sql).getResultList();
            System.out.println("Connection to database successful!");

            // Commit the transaction
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

}
