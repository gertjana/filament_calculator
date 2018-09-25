defmodule Filament do
  @derive [Poison.Encoder]
  defstruct [:code, :manufacturer, :name, :diameter, :density, :price, :weight]

  def start(_type, _args) do
		:ets.new(:filament, [:set, :public, :named_table])
		with {:ok, body} <- File.read(Path.expand("~/.filament")),
			   {:ok, materials} <- Poison.decode(body, as: [%Filament{}]) do
  	  
      :ets.insert(:filament, {:materials, materials})
    end   
    {:ok, self()}
	end

  def calculate(len, filament) do
    r = filament.diameter/20
    vol = :math.pi * len * :math.pow(r,2)
    mass = filament.density * vol
    cost = mass/filament.weight*filament.price |> Float.round(2)
    "Filament costs are #{cost} €"  
  end
  
  def add(material) do
    case get(material.code) do
      nil ->     
        with {:ok, json} <- Poison.encode([material | list()]),
             {:ok} <- File.write(Path.expand("~/.filament"), json) do
          "Added #{material.code}"       
        end   
      _ -> "Material with code #{material.code} already exists"
    end 
  end

  def list do
    :ets.lookup(:filament, :materials)[:materials]
  end

  def get(code) do
    case list() |> Enum.filter(fn m -> m.code == code end) do
      [head | _tail] -> head
      _ -> nil
    end
  end

  def stop(_state) do
    :ets.delete(:filament)
	end
end
