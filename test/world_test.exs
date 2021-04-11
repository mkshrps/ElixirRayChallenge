defmodule WorldTest do
  use ExUnit.Case
  import CoordOps
  import Ray
  import World
  import Sphere
  import Lights
  import Utils

  test "Intersect world with a ray" do
    w = default_world()
    r = ray(point(0,0,-5),vector(0,0,1))
    intersect_list = intersect_world(w,r)
    assert length(intersect_list) == 4
    assert Enum.at(intersect_list,0).t == 4
    assert Enum.at(intersect_list,1).t == 4.5

    assert Enum.at(intersect_list,2).t == 5.5
    assert Enum.at(intersect_list,3).t == 6
  end
  test " precomps" do
    r = ray(point(0,0,-5), vector(0,0,1))
    shape = sphere()
    i = intersection(4,shape)
    comps = prepare_computations(i,r)
    assert comps.t == i.t
    assert comps.object == i.object
    assert comps.point == point(0,0,-1)
    assert comps.eyev == vector(0,0,-1)
    assert comps.normalv == vector(0,0,-1)
  end

  test "hit intersection outside sphere" do
    r = ray(point(0,0,-5), vector(0,0,1))
    shape = sphere()
    i = intersection(4,shape)
    comps = prepare_computations(i,r)
    assert comps.inside == false 
  end

  test "hit on inside" do
    r = ray(point(0,0,0), vector(0,0,1))
    shape = sphere()
    i = intersection(1,shape)
    comps = prepare_computations(i,r)
    assert comps.point == point(0,0,1)
    assert comps.eyev == vector(0,0,-1)
    assert comps.inside == true
    assert comps.normalv == vector(0,0,-1)
  end

  test "shade intersection" do
    w = default_world()
    r = ray(point(0,0,-5),vector(0,0,1))
    shape = get_world_object(w.objects,0)
    i = intersection(4,shape)
    comps = prepare_computations(i,r)
     c = shade_hit(comps,w)
   # {r,g,b} = c
   # rc = {Float.round(r,5),Float.round(g,5),Float.round(b,5)}
    assert trim(c,5) == color(0.38066,0.47583,0.2855)
  end

  test "shade intersection from inside" do
    w = default_world()
    w = add_light_to_world(w,point_light(point(0,0.25,0),color(1,1,1)))
    r = ray(point(0,0,0),vector(0,0,1))
    shape = get_world_object(w.objects,1)
    i = intersection(0.5,shape)
    comps = prepare_computations(i,r)
    c = shade_hit(comps,w)
    assert trim(c,5) == color(0.90498,0.90498,0.90498)
  end

  test "color when a ray misses" do
    w = default_world()
    r = ray(point(0,0,-5),vector(0,1,0))
    c = color_at(w,r)
    assert c == color(0,0,0)
  end


  test "color when a ray hits" do
    w = default_world()
    r = ray(point(0,0,-5),vector(0,0,1))
    c = color_at(w,r)
    assert trim(c,5) == color(0.38066,0.47583,0.2855)
  end

  test "when ray is inside a sphere" do
    w = default_world()
    #outer = Enum.at(w.objects,0)
    inner = Enum.at(w.objects,1)
    r = ray(point(0,0,0.75),vector(0,0,-1))
    c = color_at(w,r)
    assert c == inner.material.color
  end
end



