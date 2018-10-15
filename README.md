# Filament calculator

Small commandline tool to calculate how much it costs to print a plastic model

note that this just calculates the price of the filament, electricity, printer wear and labor time is not included 

## Installation

have a recent version of elixir installed

clone and run `mix escript.build` this will create a binary called filament

run ./filament to get a list of available commands

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
