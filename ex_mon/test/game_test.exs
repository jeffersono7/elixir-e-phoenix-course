defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Jefferson", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Jefferson", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Jefferson"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Jefferson", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Jefferson"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Jefferson"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player of turn" do
      player = Player.build("Jefferson", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Jefferson"
      }

      assert expected_response == Game.player()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Jefferson"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      assert new_state.computer == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the turn" do
      player = Player.build("Jefferson", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      assert :player == Game.turn()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Jefferson"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      assert :computer == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player" do
      player = Player.build("Jefferson", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Robo"
      }

      assert expected_response == Game.fetch_player(:computer)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Jefferson"
      }

      assert expected_response == Game.fetch_player(:player)
    end
  end
end
