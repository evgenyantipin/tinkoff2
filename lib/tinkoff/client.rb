module Tinkoff
  class Client
    # Инициирует платежную сессию и регистрирует заказ в системе Банка
    def self.init(order_id,amount, params = {})
      params = params.merge(Amount: amount, OrderId: order_id)
      Tinkoff::Request.new('Init', params).perform
    end

    # Данный метод используется, если продавец обладает сертификацией PCI DSS
    # и использует свою собственную платежную форму вместо формы банка.
    # TODO: Implement
    def self.finish_authorize(params = {})
      Tinkoff::Request.new('FinishAuthorize', params).perform
    end

    # Подтверждает платеж и осуществляет списание заблокированных ранее денежных средств
    def self.confirm(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('Confirm', params).perform
    end

    # Осуществляет рекуррентный (повторный) платеж — безакцептное списание денежных средств
    # со счета банковской карты Покупателя
    def self.charge(payment_id, rebill_id, params = {})
      params = params.merge(PaymentId: payment_id, RebillId: rebill_id)
      Tinkoff::Request.new('Charge', params).perform
    end

    # Отменяет платежную сессию
    def self.cancel(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('Cancel', params).perform
    end

    # Возвращает текуший статус платежа
    def self.state(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('GetState', params).perform
    end

    # Отправляет закрывающий чек в кассу
    def self.send_closing_receipt(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('SendClosingReceipt', params).perform
    end
  end
end
