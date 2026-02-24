public class ClassCircularity {
  public static void main(String[] args) {
    try {
      throw new ClassCircularityError("This is a simulated class circularity error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
