// Fixture de teste: código com problemas de propósito. Não use em produção.
export function ProductCard({ product }) {
  return (
    <div onClick={() => addToCart(product.id)}>
      <img src={product.image} />
      <span className="text-[10px]">12x de R$ {product.installment} sem juros</span>
    </div>
  );
}
