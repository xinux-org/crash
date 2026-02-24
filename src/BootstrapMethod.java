public class BootstrapMethod {
  public static void main(String[] args) {
    try {
      throw new BootstrapMethodError("This is a simulated bootstrap method error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
