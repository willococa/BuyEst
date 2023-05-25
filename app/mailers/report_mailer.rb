class ReportMailer < ApplicationMailer
  def daily_report(recipient, report_data)

    @report_data = report_data
    mail(to: recipient, subject: 'Daily Report: Purchases by Product')
  end
  def no_report_data
    mail(to: 'admin@example.com', subject: 'No Report Data')
  end
end
