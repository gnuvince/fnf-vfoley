type currency = Cad | Usd

type money = { curr: currency; amount: float }

exception CurrencyMismatch

let one_cad: money = { curr=Cad; amount=1.0 }
let one_usd: money = { curr=Usd; amount=1.0 }

let add_fee (subtotal: money) (fee: money) : money =
  if subtotal.curr = fee.curr then
    { curr=subtotal.curr; amount=subtotal.amount +. fee.amount }
  else
    raise CurrencyMismatch
