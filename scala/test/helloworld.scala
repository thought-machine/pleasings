package net.thoughtmachine.please.scala

object HelloWorld
{
  def main(args: Array[String])
  {
    println(message())
  }

  def message(): String = {
    "Hello, world!"
  }
}
