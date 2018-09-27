defmodule Material do

	defstruct [:type, :density]

	def materials do
    [
      %Material{type: "ABS",   density: "1.04 g/cm^3"},
      %Material{type: "PLA",   density: "1.24 g/cm^3"},
      %Material{type: "PETG",  density: "1.23 g/cm^3"},
      %Material{type: "HIPS",  density: "1.03 - 1.04 g/cm^3"},
      %Material{type: "FLEX",  density: "1.19 - 1.23 g/cm^3"},
      %Material{type: "Nylon", density: "1.06 - 1.14 g/cm^3"}
    ]
  end
end
