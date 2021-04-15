class ReportEmailJob < Struct.new(:report_id, :community)
  def perform(*args)
    MailCarrier.deliver_later(PersonMailer.report_listing_admin_notification(report_id, community))
  end
end
