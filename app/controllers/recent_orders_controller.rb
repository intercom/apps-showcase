class RecentOrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:initialize_url]
  # , :submit_url, :submit_sheet_url
  # after_action :allow_iframe, only: :submit_sheet_url

  def initialize_url
    latest_order = Order.order(:created_at).first
    Rails.logger.info("Latest order:#{latest_order}")
    Rails.logger.info("Params for initialize_url:#{params}")
    render json: {
      canvas: {
        content: {
          components: [
            {
              "type": "text",
              "text": "*Cancel your order*",
              "style": "header"
            },
            {
              "type": "text",
              "text": "Order id #{latest_order.id}",
              "style": "header"
            },
            { type: "button", 
            label: "Verify your details", 
            style: "primary", 
            id: "verification_form", 
            action: {type: "submit"} 
          },
          ], 
        },
      },
    }
  end
end
