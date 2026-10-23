// Fixture de teste: código com problemas de propósito. Não use em produção.
const STRIPE_KEY = "sk_live_TESTE0000";

export async function placeOrder(user, cart) {
  console.log("pedido de", user.email, user.cpf);
  await db.orders.insert({ cardNumber: cart.cardNumber, cvv: cart.cvv });
}
