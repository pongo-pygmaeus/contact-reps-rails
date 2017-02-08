module EasyPostAdapter

  def self.generate_shipment(args={})

    EasyPost.api_key  = "#{ENV['EASYPOST_KEY']}"

    # Add stuff to sanitize input
    to_address_hash   = args.fetch(:to_address, "")
    from_address_hash = args.fetch(:from_address, "")

    # Sample Hash
    # {street1: "4181 Main Street",
    # city: "SACRAMENTO",
    # state: "CA",
    # zip: "94618",
    # country: "US",
    # company: "CONTACT-A-REP",
    # phone: "111-111-1111"}

    to_address = EasyPost::Address.create(to_address_hash)
    from_address = EasyPost::Address.create(from_address_hash)

    parcel = EasyPost::Parcel.create(
      predefined_package: "#{ENV['EASYPOST_PACKAGE_TYPE']}",
      weight: 3.0
    )

    p shipment = EasyPost::Shipment.create(
      to_address: to_address,
      from_address: from_address,
      parcel: parcel
    )

    shipment.buy(rate: shipment.rates.first, insurance: 1.00)
    shipment.label(file_format: "#{ENV['EASYPOST_FILE_FORMAT']}")
    shipment.postage_label.label_url
    # ***** IMPORTANT ***** Remove the following lines after verification
    # local_filename = ImageDownloader.download_file(filename: shipment.postage_label.label_url)
    # LabelPrinter.print_file(filename: local_filename)

    # print_job = PrintJob.new(filename: shipment.postage_label.label_url)
    # print_job.perform
  end
end