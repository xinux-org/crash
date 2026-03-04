public class StackOverflow {
  public static void main(String[] args) {
    try {
      infiniteRecursionMethod();
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }

  public static void infiniteRecursionMethod() {
    infiniteRecursionMethod();
  }
}
