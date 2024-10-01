import org.hibernate.Session;
import org.hibernate.Transaction;
import utils.HibernateUtil;
import Entity.Test;

public class Testu {

    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();

            // Create a new Test entity
            Test test = new Test("Sample Name");

            // Save the entity
            session.save(test);

            // Commit the transaction
            transaction.commit();
            System.out.println("Test entity inserted successfully!");

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
