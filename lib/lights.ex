defmodule Lights do
  import CoordOps, only: [color: 3,point: 3]
  @moduledoc """
  Define lights and helper functions
  """
  @doc """
  create a point light object

  %{position: position, intensity: intensity}
  """
  def point_light( position \\ point(0,0,0), intensity \\ color(1,1,1) ) do
    %{position: position, intensity: intensity}
  end
  @doc """
  set position of a light in world coordinates

  """ 
  def set_light_position(light,position) do
    Map.put(light,:position,position)
  end
  @doc """
  Set light intensity 
  """
  def set_light_intensity(light,intensity) do
    Map.put(light,:intensity,intensity)
  end


end


