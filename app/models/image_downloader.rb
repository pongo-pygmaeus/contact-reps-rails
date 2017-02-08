require 'open-uri'

module ImageDownloader

  def self.download_file(args = {})
    remote_filename = args.fetch(:filename,"")
    local_filename  = generate_filename

    open(local_filename, 'wb') do |file|
      file << open(remote_filename).read
    end

    local_filename
  end

private
  def self.generate_filename
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    filename = (0...50).map { o[rand(o.length)] }.join
    filename = "tmp/#{Time.now.to_i}-#{filename}.png"
  end
end