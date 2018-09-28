defmodule Material do

	defstruct [:type, :density, :extruder, :bed]

	def materials do
    [
      %Material{type: "ABS",   density: "1.04 g/cm^3", extruder: "220-250", bed: "95-110"},
      %Material{type: "PLA",   density: "1.24 g/cm^3", extruder: "190-220", bed: "45-60"},
      %Material{type: "PETG",  density: "1.23 g/cm^3", extruder: "230-250", bed: "75-90"},
      %Material{type: "HIPS",  density: "1.03 - 1.04 g/cm^3", extruder: "230-245", bed: "100-115"},
      %Material{type: "FLEX",  density: "1.19 - 1.23 g/cm^3", extruder: "225-245", bed: "45-60"},
      %Material{type: "Nylon", density: "1.06 - 1.14 g/cm^3", extruder: "220-270", bed: "70-90"}
    ]
  end
end
