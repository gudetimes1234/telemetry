require 'rails_helper'

RSpec.describe Document::NetworkJob, type: :job do
  let(:data) { 'test_data' }
  let(:destination_address) { 'example.com' }
  let(:destination_port) { 8080 }
  let(:source_address) { 'localhost' }
  let(:source_port) { 1234 }
  let(:protocol) { 'tcp' }
  let(:process_details) { { username: 'user', command_line: 'command' } }

  it 'logs activity without attempting to establish a connection' do
    allow(TCPSocket).to receive(:new).and_return(double('socket').as_null_object)

    expect do
      Document::NetworkJob.new.perform(data, destination_address, destination_port, source_address, source_port, protocol, process_details, 123)
    end.not_to raise_error
  end
end
