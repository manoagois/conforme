# Fixture de teste: código com problemas de propósito. Não use em produção.
def renew_subscription(sub):
    # cobra direto, sem aviso prévio
    charge(sub.customer_id, sub.amount)

def cancel_subscription(sub):
    raise NotImplementedError("cancelamento só por telefone")
