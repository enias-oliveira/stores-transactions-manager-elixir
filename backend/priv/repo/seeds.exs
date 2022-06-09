# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Backend.Repo
alias Backend.Transactions.TransactionTypes

initial_transaction_types = [
  %TransactionTypes{
    description: :debit_payment,
    entryNature: :debit
  },
  %TransactionTypes{
    description: :boleto_payment,
    entryNature: :credit
  },
  %TransactionTypes{
    description: :financing,
    entryNature: :credit
  },
  %TransactionTypes{
    description: :credit_payment,
    entryNature: :debit
  },
  %TransactionTypes{
    description: :loan_payment,
    entryNature: :debit
  },
  %TransactionTypes{
    description: :sales,
    entryNature: :debit
  },
  %TransactionTypes{
    description: :ted_payment,
    entryNature: :debit
  },
  %TransactionTypes{
    description: :doc_payment,
    entryNature: :debit
  },
  %TransactionTypes{
    description: :rent,
    entryNature: :credit
  }
]

Enum.each(initial_transaction_types, &Repo.insert/1)
