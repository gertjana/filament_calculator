# Filament calculator

Small commandline tool to calculate how much it costs to print a plastic model

note that this just calculates the price of the filament, electricity, printer wear and labor time is not included 

## Installation

have a recent version of elixir installed

clone and run `mix escript.build` this will create a binary called filament

## Usage

```
~> ./filament
No command provided
usage: Filament <command> [<args>]

Commands
   list        Lists configured filaments
   color       [code] [color] Adds extra colors for an existing filament
   materials   Lists densities and temperatures for commonly used materials
   calculate   [code] [length in cm] Calculates the price for a length of filament described by its code
   add         [code] [manufacturer] [name] [color] [diameter in mm] [density in g/cm^3] [price of spool in €] [net weight of spool in g] Adds a filament to the list
   delete      [code] the code of the filament you want to delete
```

## Docker

if you dont want to install elixir on your system, you can run it inside a docker container

clone and run `docker build -t filament_image .`

then you can run it by passing the arguments you would normally pass to the app to the docker container

```
~> docker run -it -v ~/.filament.json:/root/.filament.json filament_image materials
┌─────────────┬──────────────────────────┬──────────────────────────┬─────────────────────┐
│ "Type"      │ "Density (g/cm^3)"       │ "Extruder Temp (°C)"     │ "Bed Temp (°C)"     │
├─────────────┼──────────────────────────┼──────────────────────────┼─────────────────────┤
│ "ABS"       │ "1.04 g/cm^3"            │ "220-250"                │ "95-110"            │
│ "PLA"       │ "1.24 g/cm^3"            │ "190-220"                │ "45-60"             │
│ "PETG"      │ "1.23 g/cm^3"            │ "230-250"                │ "75-90"             │
│ "HIPS"      │ "1.03 - 1.04 g/cm^3"     │ "230-245"                │ "100-115"           │
│ "FLEX"      │ "1.19 - 1.23 g/cm^3"     │ "225-245"                │ "45-60"             │
│ "Nylon"     │ "1.06 - 1.14 g/cm^3"     │ "220-270"                │ "70-90"             │
└─────────────┴──────────────────────────┴──────────────────────────┴─────────────────────┘
```

## Examples

```
~> ./filament list
┌───────────────┬────────────────────┬────────────────────┬───────────────────────────────────────────────────────────┬─────────────────────┬────────────────────────┬─────────────────┬──────────────────┐
│ "Code"        │ "Manufacturer"     │ "Name"             │ "Color"                                                   │ "Diameter (mm)"     │ "Density (g/cm^3)"     │ "Price (€)"     │ "Weight (g)"     │
├───────────────┼────────────────────┼────────────────────┼───────────────────────────────────────────────────────────┼─────────────────────┼────────────────────────┼─────────────────┼──────────────────┤
│ "PPLA"        │ "Prusa"            │ "PLA"              │ ["Purple", "Copper", "Metallic Green", "Black"]           │ 1.75                │ 1.24                   │ 25              │ 1000             │
│ "PPETG"       │ "Prusa"            │ "PETG"             │ ["Transparent Green", "Transparent Red", "Black"]         │ 1.75                │ 1.27                   │ 23              │ 1000             │
│ "PMPF"        │ "Polymaker"        │ "Polyflex"         │ ["White"]                                                 │ 1.75                │ 1.18                   │ 50.0            │ 750              │
│ "CFCFPLA"     │ "Colorfabb"        │ "Corkfill PLA"     │ ["Brown"]                                                 │ 1.75                │ 1.18                   │ 40.0            │ 650              │
│ "FMPLA"       │ "Fiberlogy"        │ "Mineral PLA"      │ ["White"]                                                 │ 1.75                │ 1.24                   │ 50              │ 850              │
│ "PABS"        │ "Prusa"            │ "ABS"              │ ["Silvergrey"]                                            │ 1.75                │ 1.03                   │ 23              │ 1000             │
└───────────────┴────────────────────┴────────────────────┴───────────────────────────────────────────────────────────┴─────────────────────┴────────────────────────┴─────────────────┴──────────────────┘
~> ./filament add CFBF Colorfabb "Bronzefill PLA" Bronze 1.75 3.9 50 750
┌──────────────────┐
│ :result          │
├──────────────────┤
│ "Added CFBF"     │
└──────────────────┘
~> ./filament list
┌───────────────┬────────────────────┬──────────────────────┬───────────────────────────────────────────────────────────┬─────────────────────┬────────────────────────┬─────────────────┬──────────────────┐
│ "Code"        │ "Manufacturer"     │ "Name"               │ "Color"                                                   │ "Diameter (mm)"     │ "Density (g/cm^3)"     │ "Price (€)"     │ "Weight (g)"     │
├───────────────┼────────────────────┼──────────────────────┼───────────────────────────────────────────────────────────┼─────────────────────┼────────────────────────┼─────────────────┼──────────────────┤
│ "CFBF"        │ "Colorfabb"        │ "Bronzefill PLA"     │ "Bronze"                                                  │ 1.75                │ 3.9                    │ 50.0            │ 750              │
│ "PPLA"        │ "Prusa"            │ "PLA"                │ ["Purple", "Copper", "Metallic Green", "Black"]           │ 1.75                │ 1.24                   │ 25              │ 1000             │
│ "PPETG"       │ "Prusa"            │ "PETG"               │ ["Transparent Green", "Transparent Red", "Black"]         │ 1.75                │ 1.27                   │ 23              │ 1000             │
│ "PMPF"        │ "Polymaker"        │ "Polyflex"           │ ["White"]                                                 │ 1.75                │ 1.18                   │ 50.0            │ 750              │
│ "CFCFPLA"     │ "Colorfabb"        │ "Corkfill PLA"       │ ["Brown"]                                                 │ 1.75                │ 1.18                   │ 40.0            │ 650              │
│ "FMPLA"       │ "Fiberlogy"        │ "Mineral PLA"        │ ["White"]                                                 │ 1.75                │ 1.24                   │ 50              │ 850              │
│ "PABS"        │ "Prusa"            │ "ABS"                │ ["Silvergrey"]                                            │ 1.75                │ 1.03                   │ 23              │ 1000             │
└───────────────┴────────────────────┴──────────────────────┴───────────────────────────────────────────────────────────┴─────────────────────┴────────────────────────┴─────────────────┴──────────────────┘
~> ./filament calculate CFBF 874
┌────────────────────────────────────────────────────────────────────────────────┐
│ :success                                                                       │
├────────────────────────────────────────────────────────────────────────────────┤
│ "Printing 874 cm of Bronzefill PLA (Colorfabb) will cost you around €5.47"     │
└────────────────────────────────────────────────────────────────────────────────┘
~> ./filament delete CFBF
┌────────────────────┐
│ :success           │
├────────────────────┤
│ "Deleted CFBF"     │
└────────────────────┘
```
