defmodule Filament.CLI do
  use ExCLI.DSL, escript: true
  @moduledoc """
  Documentation for Filament.
  """    
  
  name "Filament"
  description "Filament calculations"

  command :delete do
    aliases [:d]
    description "[code] the code of the filament you want to delete"

    argument :code, help: "Filament code"

    run context do
      case Filament.get(context[:code]) do
        nil -> IO.puts "material #{context[:code]} not found"
        material  -> IO.puts Filament.delete(material)
      end
    end
  end

  command :add do
    aliases [:a]
    description "[code] [manufacturer] [name] [diameter in mm] [density in g/cm^3] [price roll] [weight roll in g] Adds a filament to the list"

    argument :code, help: "Filament code, must be unique"
    argument :manufacturer, help: "manufacturer of the filament"
    argument :name, help: "name of the filament"
    argument :diameter, help: "The diameter in mm (usually 1.75 mm)", type: :float
    argument :density, help: "the density of the material in g/cm^3" , type: :float
    argument :price, help: "the price for a roll", type: :float
    argument :weight, help: "the new weight of the roll in grams", type: :float

    run context do
      IO.puts Filament.add(%Filament{code: context[:code], manufacturer: context[:manufacturer], name: context[:name], diameter: context[:diameter], density: context[:density], price: context[:price], weight: context[:weight]})
    end
  end

  command :calc do
    aliases [:c]
    description "[code] [length] Calculates the price for a length of filament described by its code"
    

    argument :code, help: "Filament code"
    argument :len,  help: "length of the filament used in cm", type: :integer

    run context do
      case Filament.get(context[:code]) do
        nil -> IO.puts "material #{context[:code]} not found, maybe add it?"
        material -> IO.puts Filament.calculate(context[:len], material)
      end
    end
  end

  command :list do
    aliases [:l]
    description "List configured filaments"

    run _ do
      Filament.list() |> Enum.map(
          fn m ->
            IO.puts("#{m.code}\t#{m.manufacturer}\t#{m.name}\t#{m.diameter}\t#{m.density} g/cm^3 \t#{m.price} €\t#{m.weight} g")
          end
        ) 
    end
  end

end

