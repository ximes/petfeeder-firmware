defmodule Firmware do
  @moduledoc """
  Documentation for Firmware.
  """

  use GenServer

  @tray_gpio 18

  def start_link() do
    GenServer.start_link(__MODULE__, {}, name: :petfeeder)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_info(:timeout, s) do
    start(:"A@127.0.0.1")
    {:noreply, s}
  end

  def handle_info({:nodedown, node}, state) do
    s_node = node |> to_string

    case s_node do
      "A" <> _ ->
        IO.puts("A is down, killing myself !")
        :init.stop()

      _ ->
        :ko
    end

    {:noreply, state}
  end

  def handle_info(_, s) do
    {:noreply, s}
  end

  def start(node) do
    res = Node.monitor(node, true)
    IO.puts("Starting to monitor: #{inspect(node)}")
  end

  def handle_call(:update_setting, _, _) do
  end

  def handle_call(:get_setting, _, _) do
  end

  # ----> aynchronous request
  def handle_call({:release, {:a}}, _from, _state) do
    # if password in passwords do

    # else
    #  write_to_logfile password
    # {:reply, {:error,"wrongpassword"}, passwords}
    # end
    Pigpiox.GPIO.set_servo_pulsewidth(@tray_gpio, 2050)
    {:reply, :ok, ""}
  end

  # ----> aynchronous request
  def handle_call({:release, {:b}}, _from, _state) do
    Pigpiox.GPIO.set_servo_pulsewidth(@tray_gpio, 1150)
    {:reply, :ok, ""}
  end

  # ----> aynchronous request
  def handle_call({:release, {:both}}, _from, _state) do
    Pigpiox.GPIO.set_servo_pulsewidth(@tray_gpio, 1550)
    {:reply, :ok, ""}
  end

  def tray do
    case Pigpiox.GPIO.get_servo_pulsewidth(@tray_gpio) do
      {:ok, 1150} -> :b
      {:ok, 1550} -> :both
      {:ok, 2050} -> :a
      {_, _} -> :undetermined
    end
  end

  def update_tray(trayValue) do
    Pigpiox.GPIO.set_servo_pulsewidth(@tray_gpio, trayValue)
  end
end
