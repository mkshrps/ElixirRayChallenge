defmodule Tryout do
  import CoordOps
  import Canvas
  import P3_file

    def run_simulation(vx,vy) do
      proj = init_projectile(point(0,1,0), normalize_vector(vector(vx,vy,0)))
      env = init_environment(vector(0,-0.01,0), vector(-0.001,0,0))
      {_,y,_,_} = proj.position
     # IO.inspect(proj)
     # IO.inspect(env)
      
      canvas_map = build_canvas(1000,400,{0,0,0})
      IO.puts("canvas built #{canvas_map.width} x  #{canvas_map.height}") 
      tick(canvas_map,env,proj,0,y)
    end

    def init_projectile(start_position,start_velocity) do
     # {px,py,pz,pw} = start_position
     # {vx,vy,vz,vw} = start_velocity

      # return a map contaiing the point and vector
      %{position: start_position, velocity: start_velocity}
    end
  
    def init_environment(gravity,wind) do
      # return a map contaiing the point and vector
      %{gravity: gravity,wind: wind}
    end

    def tick(_env,_proj,1000,_y) do
      IO.puts("count = 10")
    end

    def tick(canvas_map,env,proj,count,y) when y > 0 do
      new_pos = add_tuple(proj.position, proj.velocity)
      #IO.inspect(new_pos)
      {x,y,_,_} = new_pos 
      new_vel =  add_tuple(env.gravity, proj.velocity)      
      new_vel =  add_tuple(env.wind , new_vel)
      #update maps
      proj = %{proj | :position => new_pos, :velocity => new_vel}
      #IO.inspect(env)
      #IO.inspect(proj)
      #IO.puts(y)
      canvas_map = plot_pixel(canvas_map,trunc(x*10),trunc(y*30),{1,1,1})
      IO.puts("#{trunc(x)},#{trunc(y)} ")
      tick(canvas_map,env,proj,count+1,y)
           
    end

    def tick(canvas_map,_env,_proj,_count,_) do
      IO.puts("writing file")
      generate_ppm_file(canvas_map,"test.ppm")
    end
    
  end


  
  
