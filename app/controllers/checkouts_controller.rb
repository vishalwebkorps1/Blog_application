class CheckoutsController < ApplicationController
    def show
        current_user&.set_payment_processor :stripe
        current_user&.set_payment_processor&.customer

        @checkout_session = current_user
          &.payment_processor 
          &.checkout( 
                mode: params[:payment_mode],
                line_items: params[:line_items],
                success_url: checkout_success_url,
          )
    end
    def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
        # current_user.products << Product.find_by_name(name: "My super cool pdf lecture for 9.99 ")
    end

end
