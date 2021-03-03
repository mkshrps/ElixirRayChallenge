defmodule Elixir1 do
  def double(n) do 
    n * 2
  end

  def fact(0), do: 1
  def fact(n) do
    n * fact(n-1)
  end

  def testit(0), do: 1
  def testit(n) do
    n + testit(n-1)
  end

  # function ith a default argumant defined which eliminates the need to
  # initially call the function with a second 
  def listlen(l,n\\0) 
  def listlen([],n), do: n
  def listlen([_|t],n) do
    #n=n+1
    listlen(t,n+1)
  end

  def chop((min..max)) do
    min + div(max - min,2)
  end

  
  #def guess(actual,(min..max),newguess) when (actual == ( min + div(max - min,2))) do
  def guess(actual,range) do
    guess(actual,range,chop(range))
  end

  #def guess(actual,(min..max)) when (actual == ( min + div(max - min,2))) do
  def guess(actual, _ ,newguess) when (actual == newguess) do
      IO.puts("result is ")
    IO.puts(actual)
  end
  
  def  guess(actual,(min..max),newguess) when (actual < newguess) do
    nextguess = chop((min..newguess-1))
    IO.puts("#{newguess},#{min},#{max}")
    IO.puts("< ")
    guess(actual,(min..newguess-1),nextguess)
  end

  def  guess(actual,(min..max),newguess) when (actual > newguess) do 
    nextguess =  chop((newguess+1..max))
    IO.puts("#{newguess},#{min},#{max}")
    IO.puts(">")
    guess(actual,(newguess+1..max),nextguess)
  end
  def anontest(x) do
    plus = &(&1 + 1)
    plus.(x)
    
  end
  def map([],_func) do
    IO.puts("end")
    :error

  end

  def map([head | tail],func) do
    [func.(head) | map(tail,func) ]
  end
  
  def count(x \\ 0)
  def count(x) when x >= 10, do: nil
  def count(x) do
    IO.puts(x)
    new_x = x+1
    count(new_x)
  end


  def delete_all([head|list],target) when head === target do
    delete_all(list,target)
  end  

  def delete_all([h|list],target) do
      [h|delete_all(list,target)]
  end
  
  def delete_all([],_) do 
    []
  end
end


