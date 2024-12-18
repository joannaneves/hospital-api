class PaymentsController < ApplicationController
  def create_payment_intent
    begin
      stripe = Stripe::StripeClient.new(api_key: ENV["sk_test_51N1GWMJ1FtsEHrbYxtGu3hyOnPqf1BgWypxt2n2qXcTBxBFqIdnVGmgzqFyMAqeo1QyjAB9jLvDaURpcO2iMxIt4007kaRfHeZ"])
      amount = params[:amount]
      currency = params[:currency] || "brl"

      payment_intent = stripe.payment_intents.create({
        amount: amount * 100,
        currency: currency
      })

      render json: { clientSecret: payment_intent.client_secret }
    rescue => e
      render json: { error: "Erro ao criar o pagamento: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
