defmodule MainApp.Accounts do

  alias MainApp.Accounts.Connection
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias MainApp.Repo

  alias MainApp.Accounts.Operator

  @doc """
  Returns the list of operators.

  ## Examples

      iex> list_operators()
      [%Operator{}, ...]

  """
  def list_operators do
    Repo.all(Operator)
  end

  @doc """
  Gets a single operator.

  Raises `Ecto.NoResultsError` if the Operator does not exist.

  ## Examples

      iex> get_operator!(123)
      %Operator{}

      iex> get_operator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operator!(id), do: Repo.get!(Operator, id)

  @doc """
  Updates a operator.

  ## Examples

      iex> update_operator(operator, %{field: new_value})
      {:ok, %Operator{}}

      iex> update_operator(operator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operator(%Operator{} = operator, attrs) do
    operator
    |> Operator.changeset(attrs)
    |> Repo.update()
  end
  @doc """
  Deletes a operator.

  ## Examples

      iex> delete_operator(operator)
      {:ok, %Operator{}}

      iex> delete_operator(operator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operator(%Operator{} = operator) do
    Repo.delete(operator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operator changes.

  ## Examples

      iex> change_operator(operator)
      %Ecto.Changeset{data: %Operator{}}

  """
  def change_operator(%Operator{} = operator, attrs \\ %{}) do
    Operator.changeset(operator, attrs)
  end

  """
    Returns an operator after they've been created an assigned a connection via email.
  """
  def signup_operator(email, password) do
    if (!check_operator(email)) do
      operator = Operator.create_operator()
      passwordHash = Bcrypt.hash_pwd_salt(password)
      connection = Connection.create_connection(email, passwordHash)

      Repo.get(Connection, connection.id)
      |> Repo.preload([:operator])
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:operator, operator)
      |> Repo.update()

      operator
    else
      nil # We return nil if we didn't get the operator (that is operator already exists)

    end
  end

  """
    Checks to see if an operator connection exists via email
    @return true if operator does exist and false otherwise
  """
  def check_operator(email) do
    Repo.one(from c in Connection, where: c.provider == "email" and c.uconnection1 == ^email,  select: c.id)
    |> return_operator_status
  end

  defp return_operator_status(nil) do
    false
  end

  defp return_operator_status(_) do
    true
  end

  def login_operator(email, password) do
    if (check_operator(email)) do
      [operator, passwordHash]  = Repo.one(from c in Connection,
                  where: c.provider == "email"
                  and c.uconnection1 == ^email,
                  select: [c.operator_id, c.uconnection2])

      if (Bcrypt.verify_pass(password, passwordHash)) do
        if (!operator) do
          nil
        else
          Repo.get(Operator, operator)
        end
      else
        Bcrypt.no_user_verify()
        nil
      end
    else
      nil
    end
  end
end
