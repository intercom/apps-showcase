class RecentOrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]
  # :submit_sheet_url
  # after_action :allow_iframe, only: :submit_sheet_url

  def initialize_url
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
              "text": "This is your latest order",
              "style": "text"
            },
            {
              "type": "text",
              "text": "*Order #: 123456*",
              "style": "header"
            },
            {
              "type": "divider"
            },
            {
              "type": "text",
              "text": "*2 Slippers*",
            },
            {
              "type": "text",
              "text": "*1 Coffee cup*",
            },
            {
              "type": "text",
              "text": "Do you want to cancel this one, or another?",
              "style": "text"
            },
            { 
              type: "button", 
              label: "Cancel this order", 
              style: "primary", 
              id: "cancel_order", 
              action: {type: "submit"} 
            },
            { 
              type: "button", 
              label: "Choose another", 
              style: "secondary", 
              id: "choose_another", 
              action: {type: "submit"} 
            },
          ], 
        },
      },
    }
  end

  def submit_url
    if params[:component_id] == "cancel_order"
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "*Please help us out*",
                "style": "header"
              },
              {
                "type": "text",
                "text": "Why are you cancelling this order?",
                "style": "text"
              },
              { 
                type: "button", 
                label: "Takes too long", 
                style: "secondary", 
                id: "time", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Mistake in my customer data", 
                style: "secondary", 
                id: "data_mistake", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Ordered incorrectly", 
                style: "secondary", 
                id: "ordered_incorrectly", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Purchase price is too high", 
                style: "secondary", 
                id: "price", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Don't want a credit/identity check", 
                style: "secondary", 
                id: "credit_check", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Changed my mind", 
                style: "secondary", 
                id: "changed_mind", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Forgot to use a voucher", 
                style: "secondary", 
                id: "voucher", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Other", 
                style: "secondary", 
                id: "other", 
                action: {type: "submit"} 
              },
            ], 
          },
        },
      }
    elsif params[:component_id] == "choose_another"
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "*Your recent orders*",
                "style": "header"
              },
              {
                "type": "text",
                "text": "*Order #: 234567*",
                "style": "header"
              },
              {
                "type": "spacer",
                "size": "xs"
              },
              {
                "type": "text",
                "text": "*1 Mousepad*",
              },
              {
                "type": "text",
                "text": "*1 USB Port*",
              },
              { 
                type: "button", 
                label: "Cancel this order", 
                style: "primary", 
                id: "cancel_order", 
                action: {type: "submit"} 
              },
              {
                "type": "divider"
              },
              {
                "type": "text",
                "text": "*Order #: 234567*",
                "style": "header"
              },
              {
                "type": "spacer",
                "size": "xs"
              },
              {
                "type": "text",
                "text": "*1 Mousepad*",
              },
              {
                "type": "text",
                "text": "*1 USB Port*",
              },
              { 
                type: "button", 
                label: "Cancel this order", 
                style: "primary", 
                id: "cancel_order", 
                action: {type: "submit"} 
              }
            ], 
          },
        },
      }
    end

  end
end
