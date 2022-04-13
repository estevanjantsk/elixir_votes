defmodule ElectionTest do
  use ExUnit.Case
  doctest Election

  setup do
    %{election: %Election{}}
  end

  test "updating election name from a command", ctx do
    command = "name Will Ferrell"
    election = Election.update(ctx.election, command)
    assert election == %Election{name: "Will Ferrell"}
  end

  test "adding a new candidate from a command", ctx do
    command = "a Candidate1"

    election = Election.update(ctx.election, command)

    assert election.candidates == [%Candidate{id: 1, name: "Candidate1", votes: 0}]
  end

  test "voting for a candidate from a command", ctx do
    add_command = "a Estevan"    
    command = "v 1"

    election = ctx.election 
            |> Election.update(add_command)
            |> Election.update(command)
    assert election.candidates == [%Candidate{id: 1, name: "Estevan", votes: 1}]
  end

  test "invalid command", ctx do
    command = "invalid command"

    election = ctx.election 
            |> Election.update(command)

    assert election == ctx.election
  end

  test "quitting the app", ctx do
    command = "q"

    res = Election.update(ctx.election, command)

    assert res == :quit
  end
end
