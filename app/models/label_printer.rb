module LabelPrinter

  def self.print_file(args={})
    
    filename = args.fetch(:filename,"")

    printers = CupsPrinter.get_all_printer_names
    printer  = CupsPrinter.new(printers.first)
    filename

    job = printer.print_file(filename, 'PageSize' => 'A4')
    job.status
  end
end