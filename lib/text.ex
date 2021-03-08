
defmodule Text do

  def str_add() do
    enum_test([1,2,3])
  end

  def enum_test(list) do
    Enum.each(list,  fn num  -> num+2  end)
  end

  def dothis(char,str) do
   str = str <> "#{char} " 
    IO.puts(str)
   str
  end
end

