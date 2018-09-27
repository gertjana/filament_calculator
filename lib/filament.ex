defmodule Filament do
  @store "~/.filament.json"

  @derive [Poison.Encoder]
  defstruct [:code, :manufacturer, :name, :diameter, :density, :price, :weight]

  def start(_type, _args) do
		:ets.new(:filament, [:set, :public, :named_table])
		with {:ok, body} <- File.read(Path.expand(@store)),
			   {:ok, materials} <- Poison.decode(body, as: [%Filament{}]) do
  	  
      :ets.insert(:filament, {:materials, materials})
    end   
    {:ok, self()}
	end

  def calculate(len, filament) do
    r = filament.diameter/20  # convert to radius in cm
    vol = :math.pi * len * :math.pow(r,2) # volume in cm^3
    mass = filament.density * vol # mass in g 
    cost = mass/filament.weight*filament.price |> Float.round(2)
    "Filament costs are #{cost} €"  
  end
  
  defp save(materials) do
    {:ok, json} = Poison.encode(materials,pretty: true)
    File.write(Path.expand(@store), json) 
  end   

  def delete(material) do
    filtered = list() |> Enum.filter(fn m -> m.code != material.code end)
    save(filtered)
    "Deleted #{material.code}"
  end

  def add(material) do
    case get(material.code) do
      nil ->     
        save([material | list()])
        "Added #{material.code}"       
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
