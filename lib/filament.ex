defmodule Filament do
  @store "~/.filament.json"

  @derive [Poison.Encoder]
  defstruct code: "", manufacturer: "", name: "", color: [], diameter: 1.75, density: 0.0, price: 0.0, weight: 0.0

  def start(_type, _args) do
		:ets.new(:filament, [:set, :public, :named_table])

    if !File.exists?(Path.expand(@store)), do: save([])

		with {:ok, body} <- File.read(Path.expand(@store)),
			   {:ok, filaments} <- Poison.decode(body, as: [%Filament{}]) do
      :ets.insert(:filament, {:filaments, filaments})
    end   
    {:ok, self()}
	end

  def calculate(len, filament) do
    r = filament.diameter/20  # convert to radius in cm
    vol = :math.pi * len * :math.pow(r,2) # volume in cm^3
    mass = filament.density * vol # mass in g 
    cost = mass/filament.weight*filament.price |> Float.round(2)
    "Printing #{len} cm of #{filament.name} (#{filament.manufacturer}) will cost you around €#{cost}"  
  end
  
  defp save(filaments) do
    {:ok, json} = Poison.encode(filaments,pretty: true)
    File.write!(Path.expand(@store), json) 
    :ets.insert(:filament, {:filaments, filaments})
  end   

  defp update(filament) do
    case get(filament.code) do
      nil ->
        "#{filament.code} not found, not updating"
      old ->
        delete(old)
        save([filament | list()])
        "Updated #{filament.code}"       
    end
  end

  def delete(filament) do
    filtered = list() |> Enum.filter(fn m -> m.code != filament.code end)
    save(filtered)
    "Deleted #{filament.code}"
  end

  def add(filament) do
    case get(filament.code) do
      nil ->     
        save([filament | list()])
        "Added #{filament.code}"       
      _ -> "Filament with code #{filament.code} already exists"
    end 
  end

def add_color(color, filament) do
  if color not in filament.color do
    new_filament = %{filament | color: [color | filament.color]}
    update(new_filament)
  end
end

  def list do
    :ets.lookup(:filament, :filaments)[:filaments]
  end

  def get(code) do
    case list() |> Enum.filter(fn m -> m.code == code end) do
      [head | _tail] -> head
      _ -> nil
    end
  end

  def stop(_state) do
    :ets.delete(:filaments)
	end
end
