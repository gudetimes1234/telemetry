class Document::NetworkJob
  include Sidekiq::Worker

  def perform(data, destination_address, destination_port, source_address, source_port, protocol, process_details, number_of_bytes)
    timestamp = Time.now
    email = process_details[:email]
    process_id = $$
    process_name = $PROGRAM_NAME

    begin
      socket = TCPSocket.new(destination_address, destination_port)
      socket.puts(data)
      log_activity(timestamp, email, destination_address, destination_port, source_address, source_port, data.size, protocol, process_name, command_line, process_id)
    rescue StandardError => e
      log_error(timestamp, e.message)
    ensure
      socket.close if socket
    end
  end

  private

  def log_activity(timestamp, email, destination_address, destination_port, source_address, source_port, data_size, protocol, process_name, command_line, process_id)
    logger = Logger.new('network_activity.log')

    logger.info("Timestamp: #{timestamp}")
    logger.info("Email: #{email}")
    logger.info("Destination: #{destination_address}:#{destination_port}")
    logger.info("Source: #{source_address}:#{source_port}")
    logger.info("Data Size: #{data_size} bytes")
    logger.info("Protocol: #{protocol}")
    logger.info("Process Name: #{process_name}")
    logger.info("Process ID: #{process_id}")

    logger.close
  end

  def log_error(timestamp, error_message)
    logger = Logger.new('network_errors.log')

    logger.error("Timestamp: #{timestamp}")
    logger.error("Error: #{error_message}")

    logger.close
  end
end
