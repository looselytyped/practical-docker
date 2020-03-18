
 class App {
  static main(args) {
    int i = 0;

    while(i <= 1000) {
      println("This is shadow, over " + i);
        Thread.sleep(1000);
        i++;
    }
  }
}
