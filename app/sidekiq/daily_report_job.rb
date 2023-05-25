class DailyReportJob
  include Sidekiq::Job
  include ActionView::Helpers::DateHelper

  def perform(*args)
  completed_orders = fetch_completed_orders

    if completed_orders.empty?
      log_no_report_data
      send_no_report_email
    else
      report_data = generate_report_data(completed_orders)
      send_report_email(report_data, completed_orders)
    end
  end

  private

  def fetch_completed_orders
    Order.completed
        .includes(order_items: :product)
        .where(checked_out_at: 1.day.ago..Time.now)
  end

  def log_no_report_data
    Rails.logger.info("No report data available. Skipping the report generation for #{time_ago_in_words(Time.now)}.")
  end

  def send_no_report_email
    ReportMailer.no_report_data.deliver_now
  end

  def generate_report_data(orders)
    orders.map do |order|
      order_number = order.id
      customer_name = order.client.email
      products = order.order_items.map do |item|
        {
          product_name: item.product.name,
          item_registration_id: item.id
        }
      end

      {
        order_number: order_number,
        customer_name: customer_name,
        products: products
      }
    end
  end

  def send_report_email(report_data, _completed_orders)
    completed_orders = _completed_orders
    admin_emails = Admin.pluck(:email)
    ReportMailer.daily_report(admin_emails, report_data).deliver_now
  end
end
