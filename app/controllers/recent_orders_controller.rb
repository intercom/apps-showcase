class RecentOrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]

  def initialize_url
    order_file = File.read('./lib/data/orders.json')
    orders = JSON.parse(order_file)
    latest_order = orders.first #Should actually sort by date
    render json: RecentOrders.cancel_order_canvas(order: latest_order)
  end

  def submit_url
    case params[:component_id]
    when /\Acancel_order_/
      order_id = extract_order_id(component_id: params[:component_id])
      if order_id.present?
        # Cancel the order
        render json: RecentOrders.reason_to_cancel_order_canvas
      else
        Rails.logger.info("Order id not found. Component_id: #{params[:component_id]}")
        render json: RecentOrders.error_canvas
      end
    when "choose_another"
      order_file = File.read('./lib/data/orders.json')
      orders = JSON.parse(order_file)
      orders.drop(1)
      render json: RecentOrders.recent_orders_canvas(orders: orders)
    when /\Areason_/
      cancel_reason = extract_cancel_reason(component_id: params[:component_id])
      # Do something with cancel_reason
      Rails.logger.info("Cancelling order for reason: #{}")
      render json: RecentOrders.feedback_canvas
    when "submit_feedback"
      # Do something with feedback submitted
      Rails.logger.info("Feedback submitted: #{params[:input_values]}")
      render json: RecentOrders.feedback_submitted_canvas
    when "skip"
      render json: RecentOrders.no_feedback_submitted_canvas
    else
      render json: RecentOrders.error_canvas
    end
  end

  #MOVE SOMEWHERE ELSE
  def extract_order_id(component_id:)
    component_id.match(/.*_(\w+)/)[1]
  end

  def extract_cancel_reason(component_id:)
    component_id.match(/.*_(\w+)/)[1]
  end
end
