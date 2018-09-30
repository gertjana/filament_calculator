defmodule Filament.CLI do
  use ExCLI.DSL, escript: true
  @moduledoc """
  Documentation for Filament.
  """    
  

  defp print_table(data, options \\ [style: Scribe.Style.Pseudo]), do: Scribe.print(data, options)
  defp print_message(result, message, options \\ [style: Scribe.Style.Pseudo]), do: Scribe.print(%{result => message}, options)

  name "Filament"
  description "Filament calculations"

  command :delete do
    aliases [:d, :del]
    description "[code] the code of the filament you want to delete"

    argument :code, help: "Filament code"

    run context do
      case Filament.get(context[:code]) do
        nil -> print_message(:failure, "material #{context[:code]} not found")
        material  ->print_message(:success, Filament.delete(material))
      end
    end
  end

  command :add do
    aliases [:a]
    description "[code] [manufacturer] [name] [color] [diameter in mm] [density in g/cm^3] [price of spool in €] [net weight of spool in g] Adds a filament to the list"

    argument :code, help: "Filament code, must be unique"
    argument :manufacturer, help: "The manufacturer of the filament"
    argument :name, help: "The name of the filament"
    argument :color, help: "The color of the filament"
    argument :diameter, help: "The diameter in mm (usually 1.75 mm)", type: :float
    argument :density, help: "The density of the material in g/cm^3" , type: :float
    argument :price, help: "The price for a spool", type: :float
    argument :weight, help: "The net weight of the spool in grams", type: :float

    run context do
      print_message(:result,Filament.add(
        %Filament{code: context[:code], 
                  manufacturer: context[:manufacturer], 
                  name: context[:name], 
                  color: context[:color], 
                  diameter: context[:diameter], 
                  density: context[:density], 
                  price: context[:price], 
                  weight: context[:weight]
        }
      ))
    end
  end

  command :calculate do
    aliases [:c, :calc]
    description "[code] [length in cm] Calculates the price for a length of filament described by its code"
    
    argument :code, help: "Filament code"
    argument :len,  help: "length of the filament used in cm", type: :integer

    run context do
      case Filament.get(context[:code]) do
        nil -> print_message(:failure, "material #{context[:code]} not found, maybe add it?")
        material -> print_message(:success, Filament.calculate(context[:len], material))
      end
    end
  end
  
  command :materials do
    aliases [:m, :mat]
    description "Lists densities for commonly used materials"
    run _ do
      Material.materials |> print_table(data: [
        {"Type", :type},
        {"Density (g/cm^3)", :density},
        {"Extruder Temp (°C)", :extruder},
        {"Bed Temp (°C)", :bed}
      ], style: Scribe.Style.Pseudo)
    end
  end

  command :list do
    aliases [:l, :ls]
    description "Lists configured filaments"

    run _ do
      Filament.list() |> print_table(data: [
        {"Code", :code}, 
        {"Manufacturer", :manufacturer}, 
        {"Name",:name},
        {"Color",:color},
        {"Diameter (mm)",:diameter},
        {"Density (g/cm^3)",:density},
        {"Price (€)",:price},
        {"Weight (g)",:weight}
      ], style: Scribe.Style.Pseudo)
    end
  end

end

