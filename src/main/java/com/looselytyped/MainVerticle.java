package com.looselytyped;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import io.vertx.core.http.HttpServer;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.mongo.MongoClient;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.handler.StaticHandler;
import io.vertx.ext.web.handler.TemplateHandler;
import io.vertx.ext.web.templ.HandlebarsTemplateEngine;

public class MainVerticle extends AbstractVerticle {

  private static final int PORT = 8080;
  private MongoClient client;

  @Override
  public void start(Future<Void> startFuture) throws Exception {
    setUpMongo();
    insertSomeData();

    Router router = Router.router(vertx);
    staticHandler(router);
    router.route("/friends.hbs").handler(this::getFriends);
    dynamicPages(router);

    HttpServer server = vertx.createHttpServer();
    server.requestHandler(router::accept);
    server.listen(PORT, result -> {
      if (result.succeeded()) {
        startFuture.complete();
      } else {
        startFuture.fail(result.cause());
      }
    });
  }

  private void staticHandler(Router router) {
    StaticHandler staticHandler = StaticHandler.create();
    staticHandler.setCachingEnabled(false);
    router.route("/assets/*").handler(staticHandler);
  }

  private void dynamicPages(Router router) {
    HandlebarsTemplateEngine hbsEngine = HandlebarsTemplateEngine.create();
    hbsEngine.setMaxCacheSize(0);
    TemplateHandler templateHandler = TemplateHandler.create(hbsEngine);
    router.getWithRegex(".+\\.hbs").handler(templateHandler);
  }

  private void setUpMongo() {
    JsonObject mongoconfig = new JsonObject()//
        .put("connection_string", "mongodb://mongo:27017")//
        .put("db_name", "friends");
    client = MongoClient.createNonShared(vertx, mongoconfig);
  }

  @Override
  public void stop(Future<Void> future) {
    client.dropCollection("friends", r -> {
      if (r.succeeded()) {
        System.out.println("SUCCESS: Collection dropped");
      } else {
        System.out.println("FAILED: Collection drop");
      }
      future.complete();
    });
  }

  private void getFriends(RoutingContext routingContext) {
    JsonObject query = new JsonObject();
    client.find("friends", query, res -> {
      routingContext.data().put("friends", res.result());
      routingContext.next();
    });
  }

  private void insertSomeData() {
    JsonObject friend1 = new JsonObject().put("firstName", "Michelle").put("since", "2011");
    JsonObject friend2 = new JsonObject().put("firstName", "Venkat").put("since", "2010");
    JsonObject friend3 = new JsonObject().put("firstName", "Matt").put("since", "2006");

    client.save("friends", friend1, Future.future());
    client.save("friends", friend2, Future.future());
    client.save("friends", friend3, Future.future());
  }
}
