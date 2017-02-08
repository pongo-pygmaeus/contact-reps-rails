class PrintJob < ApplicationJob
  queue_as :default

  def perform(args={})

    to_address_hash = args.fetch(:to_address,"")
    from_address_hash = args.fetch(:from_address,"")

    Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
    remote_label_location = EasyPostAdapter.generate_shipment(
                             to_address:   to_address_hash,
                             from_address: from_address_hash)

    Rails.logger.debug "#{self.class.name}: #{remote_label_location}"

    local_label_location = ImageDownloader.download_file(filename: remote_label_location)

    Rails.logger.debug "#{self.class.name}: #{local_label_location}"

    LabelPrinter.print_file(filename: local_label_location)

  end
end