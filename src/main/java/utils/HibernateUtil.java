package utils;

import io.vertx.core.Vertx;
import io.vertx.hibernate.reactive.ReactiveSessionFactory;

public class HibernateUtil {

    private static ReactiveSessionFactory sessionFactory;

    static {
        Vertx vertx = Vertx.vertx();
        sessionFactory = ReactiveSessionFactory.build("hibernate.cfg.xml", vertx);
    }

    public static ReactiveSessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
