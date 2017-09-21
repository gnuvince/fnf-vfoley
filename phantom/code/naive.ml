type money = float

let one_cad: money = 1.0
let one_usd: money = 1.0

let add_fee (subtotal: money) (fee: money) : money =
  subtotal +. fee
