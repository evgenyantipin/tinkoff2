require 'test_helper'

class TinkoffTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tinkoff::VERSION
  end

  def test_it_does_something_useful
    assert true
  end
end

class TinkoffPaymentQRTest < Minitest::Test
  def test_payment_has_qr_attributes
    response = {
      'TerminalKey' => 'TestTerminal',
      'PaymentId' => 12345,
      'Success' => true,
      'ErrorCode' => '0',
      'DataType' => 'IMAGE',
      'Data' => 'iVBORw0KGgoAAAANSUhEUg=='
    }
    payment = Tinkoff::Payment.new(response)

    assert_equal 'IMAGE', payment.data_type
    assert_equal 'iVBORw0KGgoAAAANSUhEUg==', payment.data
  end

  def test_payment_qr_payload_type
    response = {
      'TerminalKey' => 'TestTerminal',
      'PaymentId' => 12345,
      'Success' => true,
      'ErrorCode' => '0',
      'DataType' => 'PAYLOAD',
      'Data' => 'https://qr.nspk.ru/BCR2BB0001SK'
    }
    payment = Tinkoff::Payment.new(response)

    assert_equal 'PAYLOAD', payment.data_type
    assert_equal 'https://qr.nspk.ru/BCR2BB0001SK', payment.data
  end

  def test_payment_qr_attributes_nil_when_absent
    response = {
      'TerminalKey' => 'TestTerminal',
      'PaymentId' => 12345,
      'Success' => true,
      'ErrorCode' => '0'
    }
    payment = Tinkoff::Payment.new(response)

    assert_nil payment.data_type
    assert_nil payment.data
  end
end
