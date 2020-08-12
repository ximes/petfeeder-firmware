defmodule PetfeederFirmwareTest do
  use ExUnit.Case
  doctest PetfeederFirmware

  test "greets the world" do
    assert PetfeederFirmware.hello() == :world
  end
end
