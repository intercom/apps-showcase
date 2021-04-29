class RecentOrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]
  # :submit_sheet_url
  # after_action :allow_iframe, only: :submit_sheet_url

  def initialize_url
    order_file = File.read('./lib/data/orders.json')
    orders = JSON.parse(order_file)
    latest_order = orders.first #Should actually sort by date
    render json: RecentOrders.cancel_order_canvas(order: latest_order)
  end

  def submit_url
    order_id = extract_order_id(component_id: params[:component_id])
    case params[:component_id]
    when /\Acancel_order_/
      if order_id.present?
        render json: RecentOrders.cancel_order_component(order_id: order_id)
      else
        #Add error component
      end
    when "choose_another"
      render json: RecentOrders.recent_orders_component()
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
      Rails.logger.info("Feedback submitted: #{params[:input_values]}")
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Thank you for your feedback. Your order has been canceled",
                "style": "header"
              },
            ], 
          },
        },
      }
    when "skip"
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Your order has been canceled",
                "style": "header"
              },
            ], 
          },
        },
      }
    else
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Something went wrong",
                "style": "header"
              },
            ], 
          },
        },
      }
    end
  end

  #MOVE SOMEWHERE ELSE
  def extract_order_id(component_id:)
    component_id.match(/.*_(\w+)/)[1]
  end
end
