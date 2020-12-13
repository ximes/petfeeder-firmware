defmodule ApiWeb.Resolvers.PetFeeder do
  def tray(_, _, _) do
    {:ok, Firmware.tray}
  end

  def release(_parent, args = {trayName, _}, _resolution) do
    Firmware.update_tray(trayName)

    {:ok, Firmware.tray}
  end
end
