package net.thoughtmachine.please.scala;

import org.junit.Test;

import static org.junit.Assert.*;

public class HelloTest {
  @Test
  public void testMessage() {
    assertTrue(HelloWorld.message().startsWith("Hello"));
  }
}
