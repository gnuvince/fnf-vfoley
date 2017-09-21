module type MONEY = sig
  type 'a money
  type cad
  type usd

  val one_cad : cad money
  val one_usd : usd money

  val add_fee : 'a money -> 'a money -> 'a money
  val convert : 'a money -> float -> 'b money
  val to_float : 'a money -> float
end

module Money : MONEY = struct
  type 'a money = float
  type cad
  type usd

  let one_cad = 1.0
  let one_usd = 1.0

  let add_fee subtotal fee = subtotal +. fee
  let convert amount rate = amount *. rate
  let to_float amount = amount
end
