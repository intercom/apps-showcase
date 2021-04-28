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
              "text": "This is your latest order #{params[:context][:location]} as of #{Time.now}",
              "style": "paragraph"
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
              "style": "paragraph"
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
    case params[:component_id]
    when /\Acancel_order_/
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
                "style": "paragraph"
              },
              { 
                type: "button", 
                label: "Takes too long", 
                style: "secondary", 
                id: "reason_time", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Mistake in my customer data", 
                style: "secondary", 
                id: "reason_data_mistake", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Ordered incorrectly", 
                style: "secondary", 
                id: "reason_ordered_incorrectly", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Purchase price is too high", 
                style: "secondary", 
                id: "reason_price", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Don't want a credit/identity check", 
                style: "secondary", 
                id: "reason_credit_check", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Changed my mind", 
                style: "secondary", 
                id: "reason_changed_mind", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Forgot to use a voucher", 
                style: "secondary", 
                id: "reason_voucher", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Other", 
                style: "secondary", 
                id: "reason_other", 
                action: {type: "submit"} 
              },
            ], 
          },
        },
      }
    when "choose_another"
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
                "style": "paragraph"
              },
              {
                "type": "text",
                "text": "*1 USB Port*",
                "style": "paragraph"
              },
              { 
                type: "button", 
                label: "Cancel this order", 
                style: "primary", 
                id: "cancel_order_1", 
                action: {type: "submit"} 
              },
              {
                "type": "divider"
              },
              {
                "type": "text",
                "text": "*Order #: 345678*",
                "style": "header"
              },
              {
                "type": "spacer",
                "size": "xs"
              },
              {
                "type": "text",
                "text": "*1 Lamp*",
                "style": "paragraph"
              },
              {
                "type": "text",
                "text": "*2 Pillow*",
                "style": "paragraph"
              },
              { 
                type: "button", 
                label: "Cancel this order", 
                style: "primary", 
                id: "cancel_order_2", 
                action: {type: "submit"} 
              }
            ], 
          },
        },
      }
    when /\Areason_/
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
                "type": "textarea",
                "id": "feedback",
                "label": "Any additional comments? Feel free to leave them here",
                "placeholder": "Leave your feedback..."
              },
              { 
                type: "button", 
                label: "Submit feedback", 
                style: "primary", 
                id: "submit_feedback", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Skip", 
                style: "secondary", 
                id: "skip", 
                action: {type: "submit"} 
              }
            ], 
          },
        },
      }
    when "submit_feedback"
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Thank you for your feedback",
                "style": "header"
              },
            ], 
          },
        },
      }
    when "skip"
      "Do something"
    else
      "Something went wrong"
    end
  end
end
