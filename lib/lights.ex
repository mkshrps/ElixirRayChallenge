defmodule Lights do
  import CoordOps, only: [color: 3,point: 3]

  def point_light( position \\ point(0,0,0), intensity \\ color(1,1,1) ) do
    %{position: position, intensity: intensity}
  end

  def set_light_position(light,position) do
    Map.put(light,:position,position)
  end

  def set_light_intensity(light,intensity) do
    Map.put(light,:intensity,intensity)
  end


end


