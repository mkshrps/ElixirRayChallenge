defmodule LightShadeTest do
  use ExUnit.Case
  doctest Shading
  import CoordOps
  import Ray
  import Math
  import Shading
  import Matrix
  import Sphere
  import Material

  test "eye beween light and surface" do
    m = material()
    position = point(0,0,0)
    eyev = vector(0,0,-1)
    normalv = vector(0,0,-1)
    light = point_light(point(0,0,-10),color(1,1,1))
    result = lighting(m,light,position,eyev,normalv)
    assert result == color(1.9,1.9,1.9)
  end

  test "eye light and surface eye offset 45deg" do
    m = material()
    position = point(0,0,0)
    eyev = vector(0,sqrt(2)/2,sqrt(2)/2)
    normalv = vector(0,0,-1)
    light = point_light(point(0,0,-10),color(1,1,1))
    result = lighting(m,light,position,eyev,normalv)
    assert result == color(1.0,1.0,1.0)
  end
  
  test "eye opposite surface and light offset 45deg " do
    m = material()
    position = point(0,0,0)
    eyev = vector(0,0,-1)
    normalv = vector(0,0,-1)
    light = point_light(point(0,10,-10),color(1,1,1))
    result = lighting(m,light,position,eyev,normalv)
    assert result == color(0.7364,0.7364,0.7364)
  end
  test "eye in path of reflected vector" do
    m = material()
    position = point(0,0,0)
    eyev = vector(0,-sqrt(2)/2,-sqrt(2)/2)
    normalv = vector(0,0,-1)
    light = point_light(point(0,10,-10),color(1,1,1))
    result = lighting(m,light,position,eyev,normalv)
    assert result == color(1.6364,1.6364,1.6364)
  end

  test "light behind the surface " do
    m = material()
    position = point(0,0,0)
    eyev = vector(0,0,-1)
    normalv = vector(0,0,-1)
    light = point_light(point(0,0,10),color(1,1,1))
    result = lighting(m,light,position,eyev,normalv)
    assert result == color(0.1,0.1,0.1)
  end


  test "point light has psoition and intensity" do
    intensity = color(1,1,1)
    position = point(0,0,0)
    light = point_light(position,intensity)
    assert  light.position == position
    assert  light.intensity == intensity
  end

  test " material " do
    m = material()
    assert m.color == color(1,1,1)
    assert m.ambient == 0.1
    assert m.diffuse == 0.9
    assert m.specular == 0.9
    assert m.shininess == 200.0
  end

  test "sphere has default material" do
    s = sphere()
    m = s.material
    assert m == material()
  end

  test " spherre may be assigned a material" do
    s = sphere()
    m = material()
    m = update_material(m,:ambient,1)
    s = update_sphere(s,:material,m)
    assert s.material == m
  end


  test "reflecting vextor approaching at 45 deg " do
    r = reflect(vector(1,-1,0),vector(0,1,0))
    assert r == vector(1,1,0)
  end

  test "reflect vector off a slanted surface" do
    r = reflect(vector(0,-1,0),vector(sqrt(2)/2,sqrt(2)/2,0))
    assert matrix_equal?(r, vector(1,0,0))
  end


  test "normal on sphere x axis" do
    s = sphere()
    n = normal_at(s,point(1,0,0))
    assert n == vector(1,0,0)
    
  end
  test "normal on sphere y axis" do
    s = sphere()
    n = normal_at(s,point(0,1,0))
    assert n == vector(0,1,0)
    
  end
  test "normal on sphere z axis" do
    s = sphere()
    n = normal_at(s,point(0,0,1))
    assert n == vector(0,0,1)
 
  end

  test "normal on sphere nonaxial point " do
    s = sphere()
    n = normal_at(s,point(sqrt(3)/3,sqrt(3)/3,sqrt(3)/3))
    assert n == vector(sqrt(3)/3,sqrt(3)/3,sqrt(3)/3)
  end

  test "normal is normalised vector " do
    s = sphere()
    n = normal_at(s,point(sqrt(3)/3,sqrt(3)/3,sqrt(3)/3))
    assert n == normalize(n) 
  end



end

